import 'package:edulab_b2b/widget_imports.dart';
// Prefixed because flutter_widget_from_html_core also exports an `ImageSource`.
import 'package:image_picker/image_picker.dart' as picker;

/// Longest edge we ask the gallery for. The crop only ever emits a 512px
/// square, so decoding anything larger just costs memory.
const double _maxPickedEdge = 2048;

/// Opens the gallery, then the crop screen, and returns the cropped square PNG.
///
/// Returns null if the user cancelled at either step. "Select another photo" on
/// the crop screen loops back to the gallery rather than ending the flow.
Future<Uint8List?> pickAndCropAvatar(BuildContext context) async {
  while (true) {
    final picked = await _pickFromGallery(context);
    if (picked == null || !context.mounted) return null;

    final result = await Navigator.push<CropAvatarResult>(
      context,
      CustomCupertinoStyleNavigationRoute<CropAvatarResult>(
        builder: (_) => CropAvatarPage(imageBytes: picked),
      ),
    );

    if (result == null || !context.mounted) return null;
    if (result.reselect) continue;

    return result.bytes;
  }
}

Future<Uint8List?> _pickFromGallery(BuildContext context) async {
  try {
    final file = await picker.ImagePicker().pickImage(
      source: picker.ImageSource.gallery,
      maxWidth: _maxPickedEdge,
      maxHeight: _maxPickedEdge,
      imageQuality: 90,
    );

    return file == null ? null : await file.readAsBytes();
  } on PlatformException catch (e) {
    if (!context.mounted) return null;

    // The plugin reports a refused library prompt as a plain platform error,
    // so tell the user where to turn it back on rather than showing "error".
    final isDenied = e.code == 'photo_access_denied';
    showMessage(
      isDenied
          ? context.localizations.photoAccessDenied
          : context.localizations.somethingWentWrong,
      context,
      isError: true,
    );
    return null;
  } catch (_) {
    if (!context.mounted) return null;

    showMessage(context.localizations.somethingWentWrong, context, isError: true);
    return null;
  }
}
