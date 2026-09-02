import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:edulab_b2b/widget_imports.dart';

/// Side of the square PNG the crop produces. Comfortably above every place the
/// avatar is drawn, without shipping a multi-megabyte upload.
const double _outputSize = 512;

const double _minScale = 1;
const double _maxScale = 5;

/// Step applied by the - / + buttons.
const double _zoomStep = 1.3;

/// Lets the user position a circular window over [imageBytes] and returns the
/// cropped square PNG, or null if they backed out.
///
/// Pan and zoom are hand-rolled rather than delegated to `InteractiveViewer`
/// because the constraint that matters here - "the circle is always covered by
/// the image" - can't be expressed with `boundaryMargin` when the circle is
/// smaller than the viewport, and because the - / + / Reset controls need to
/// drive the transform programmatically.
class CropAvatarPage extends StatefulWidget {
  final Uint8List imageBytes;

  const CropAvatarPage({super.key, required this.imageBytes});

  @override
  State<CropAvatarPage> createState() => _CropAvatarPageState();
}

class _CropAvatarPageState extends State<CropAvatarPage> {
  ui.Image? _image;
  bool _isCropping = false;

  /// Centre of the image in stage coordinates.
  Offset _center = Offset.zero;
  double _scale = 1;

  /// Size of the image at [_scale] == 1, i.e. just covering the crop circle.
  Size _baseSize = Size.zero;

  Size _stageSize = Size.zero;
  double _circleDiameter = 0;

  Offset _gestureStartCenter = Offset.zero;
  Offset _gestureStartFocalPoint = Offset.zero;
  double _gestureStartScale = 1;

  @override
  void initState() {
    super.initState();
    _decode();
  }

  @override
  void dispose() {
    _image?.dispose();
    super.dispose();
  }

  Future<void> _decode() async {
    final codec = await ui.instantiateImageCodec(widget.imageBytes);
    final frame = await codec.getNextFrame();

    if (!mounted) {
      frame.image.dispose();
      return;
    }

    setState(() => _image = frame.image);
  }

  /// Recomputes the layout-dependent geometry. Called from the layout builder,
  /// so it must not call setState.
  void _layout(Size stageSize) {
    final image = _image;
    if (image == null) return;

    final diameter = stageSize.shortestSide * 0.72;
    final isSameStage = stageSize == _stageSize && diameter == _circleDiameter;
    if (isSameStage) return;

    _stageSize = stageSize;
    _circleDiameter = diameter;

    final aspect = image.width / image.height;
    _baseSize = aspect >= 1
        ? Size(diameter * aspect, diameter)
        : Size(diameter, diameter / aspect);

    _reset();
  }

  Offset get _stageCenter => Offset(_stageSize.width / 2, _stageSize.height / 2);

  Size get _displaySize => _baseSize * _scale;

  /// Zoom the screen opens at, and the one Reset goes back to: enough to fill
  /// the whole stage, so the photo reads full-bleed the way the design shows
  /// it. Scale 1 only covers the circle, and stays reachable by zooming out so
  /// nothing in a very wide or very tall photo is out of reach.
  double get _initialScale {
    if (_baseSize.isEmpty) return 1;

    final cover = math.max(
      _stageSize.width / _baseSize.width,
      _stageSize.height / _baseSize.height,
    );

    return cover.clamp(_minScale, _maxScale);
  }

  void _reset() {
    _scale = _initialScale;
    _center = _stageCenter;
  }

  /// Keeps the image covering the crop circle no matter how it was moved.
  Offset _clamp(Offset center, double scale) {
    final display = _baseSize * scale;
    final slackX = (display.width - _circleDiameter) / 2;
    final slackY = (display.height - _circleDiameter) / 2;

    return Offset(
      center.dx.clamp(_stageCenter.dx - slackX, _stageCenter.dx + slackX),
      center.dy.clamp(_stageCenter.dy - slackY, _stageCenter.dy + slackY),
    );
  }

  void _onScaleStart(ScaleStartDetails details) {
    _gestureStartCenter = _center;
    _gestureStartFocalPoint = details.localFocalPoint;
    _gestureStartScale = _scale;
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    final scale = (_gestureStartScale * details.scale).clamp(
      _minScale,
      _maxScale,
    );

    // Hold whatever sat under the fingers in place while they move and pinch.
    final anchor = _gestureStartFocalPoint - _gestureStartCenter;
    final center =
        details.localFocalPoint - anchor * (scale / _gestureStartScale);

    setState(() {
      _scale = scale;
      _center = _clamp(center, scale);
    });
  }

  void _zoomBy(double factor) {
    final previousScale = _scale;
    final scale = (previousScale * factor).clamp(_minScale, _maxScale);
    if (scale == previousScale) return;

    setState(() {
      // Zoom about the circle's centre, which is where the user is looking.
      final anchor = _stageCenter - _center;
      _scale = scale;
      _center = _clamp(_stageCenter - anchor * (scale / previousScale), scale);
    });
  }

  Future<void> _confirm() async {
    final image = _image;
    if (image == null || _isCropping) return;

    setState(() => _isCropping = true);

    try {
      final bytes = await _crop(image);
      if (!mounted) return;

      Navigator.pop(context, CropAvatarResult.cropped(bytes));
    } catch (_) {
      if (!mounted) return;

      setState(() => _isCropping = false);
      showMessage(context.localizations.somethingWentWrong, context, isError: true);
    }
  }

  /// Maps the crop circle's bounding square from stage coordinates back into
  /// source pixels and redraws just that region at [_outputSize].
  Future<Uint8List> _crop(ui.Image image) async {
    final display = _displaySize;
    final topLeft = _center - Offset(display.width / 2, display.height / 2);

    final pixelsPerStageUnit = image.width / display.width;
    final circleTopLeft =
        _stageCenter - Offset(_circleDiameter / 2, _circleDiameter / 2);

    final source = Rect.fromLTWH(
      (circleTopLeft.dx - topLeft.dx) * pixelsPerStageUnit,
      (circleTopLeft.dy - topLeft.dy) * pixelsPerStageUnit,
      _circleDiameter * pixelsPerStageUnit,
      _circleDiameter * pixelsPerStageUnit,
    );

    final recorder = ui.PictureRecorder();
    Canvas(recorder).drawImageRect(
      image,
      source,
      const Rect.fromLTWH(0, 0, _outputSize, _outputSize),
      Paint()..filterQuality = FilterQuality.high,
    );

    final picture = recorder.endRecording();
    final cropped = await picture.toImage(
      _outputSize.toInt(),
      _outputSize.toInt(),
    );
    picture.dispose();

    try {
      final data = await cropped.toByteData(format: ui.ImageByteFormat.png);
      if (data == null) throw StateError('Encoding the cropped avatar failed');

      return data.buffer.asUint8List();
    } finally {
      cropped.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    final lang = context.localizations;

    return Scaffold(
      backgroundColor: context.colors.bgPage3,
      appBar: CropAvatarPageAppBar(context),
      body: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            children: [
              Expanded(child: _stage(context)),
              space12,
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () =>
                    Navigator.pop(context, const CropAvatarResult.reselect()),
                child: Container(
                  height: 48.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: context.colors.neutralContainerDefault.withOpacity(
                      0.1,
                    ),
                    borderRadius: BorderRadius.circular(999.r),
                  ),
                  child: Text(
                    lang.selectAnotherPhoto,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.16,
                      color: context.colors.neutralOnContainer,
                    ),
                  ),
                ),
              ),
              space8,
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: _confirm,
                child: Container(
                  height: 48.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(999.r),
                  ),
                  child: _isCropping
                      ? SizedBox(
                          width: 18.w,
                          height: 18.w,
                          child: CircularProgressIndicator(
                            color: context.colors.float,
                            strokeWidth: 2.w,
                          ),
                        )
                      : Text(
                          lang.confirmButton,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.16,
                            color: context.colors.float,
                          ),
                        ),
                ),
              ),
              space12,
            ],
          ),
        ),
      ),
    );
  }

  Widget _stage(BuildContext context) {
    final image = _image;

    return ClipRRect(
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        color: context.colors.bgSurface1,
        child: image == null
            ? const Center(child: CircularProgressIndicator())
            : LayoutBuilder(
                builder: (context, constraints) {
                  _layout(constraints.biggest);

                  return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onScaleStart: _onScaleStart,
                    onScaleUpdate: _onScaleUpdate,
                    child: Stack(
                      children: [
                        Positioned(
                          left: _center.dx - _displaySize.width / 2,
                          top: _center.dy - _displaySize.height / 2,
                          width: _displaySize.width,
                          height: _displaySize.height,
                          child: RawImage(
                            image: image,
                            fit: BoxFit.fill,
                            filterQuality: FilterQuality.medium,
                          ),
                        ),
                        Positioned.fill(
                          child: IgnorePointer(
                            child: CustomPaint(
                              painter: CropCirclePainter(
                                diameter: _circleDiameter,
                                scrimColor: context.colors.bgSurface1
                                    .withOpacity(0.72),
                                ringColor: context.colors.float,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 16.h,
                          child: Center(
                            child: CropZoomControls(
                              onZoomOut: () => _zoomBy(1 / _zoomStep),
                              onZoomIn: () => _zoomBy(_zoomStep),
                              onReset: () => setState(_reset),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}

/// What [CropAvatarPage] hands back. A plain `Uint8List?` couldn't tell
/// "Select another photo" apart from a cancel.
class CropAvatarResult {
  /// The cropped square PNG, or null when the user asked for another photo.
  final Uint8List? bytes;

  /// True when the caller should reopen the gallery.
  final bool reselect;

  const CropAvatarResult.cropped(Uint8List this.bytes) : reselect = false;

  const CropAvatarResult.reselect() : bytes = null, reselect = true;
}
