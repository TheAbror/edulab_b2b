import 'package:edulab_b2b/widget_imports.dart';

class LearningPageVideoTab extends StatefulWidget {
  final StepModel step;
  final VoidCallback markAsComplete;
  final TabController tabController;

  const LearningPageVideoTab({
    super.key,
    required this.step,
    required this.markAsComplete,
    required this.tabController,
  });

  @override
  State<LearningPageVideoTab> createState() => _LearningPageVideoTabState();
}

class _LearningPageVideoTabState extends State<LearningPageVideoTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  late VoidCallback _tabListener;

  VideoPlayerController? _videoController;
  ChewieController? _chewieController;

  bool _isLoading = false;
  bool _hasError = false;

  double _progress = 0.0; // 0–1 progress
  // ignore: unused_field
  bool _canComplete = false; // unlock after 80%

  @override
  void initState() {
    super.initState();
    _initializeVideo();

    _tabListener = () {
      if (widget.tabController.indexIsChanging) {
        _videoController?.pause();
      }
    };

    widget.tabController.addListener(_tabListener);
  }

  Future<void> _initializeVideo() async {
    final url = widget.step.media?.originalUrl ?? "";

    if (url.isEmpty) {
      setState(() => _hasError = true);
      return;
    }

    setState(() => _isLoading = true);

    try {
      _videoController = VideoPlayerController.networkUrl(Uri.parse(url));
      await _videoController!.initialize();

      // Track progress
      _videoController!.addListener(_handleVideoProgress);

      _chewieController = ChewieController(
        videoPlayerController: _videoController!,
        autoPlay: false,
        looping: false,
        allowFullScreen: true,
        allowMuting: true,
        showControls: true,
        materialProgressColors: ChewieProgressColors(
          playedColor: Colors.blue,
          handleColor: Colors.blue,
          backgroundColor: Colors.grey,
          bufferedColor: Colors.grey.shade400,
        ),
        placeholder: Container(color: Colors.black),
      );

      if (mounted) {
        setState(() {
          _isLoading = false;
          _hasError = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _hasError = true;
        });
      }
    }
  }

  void _handleVideoProgress() {
    if (!mounted || _videoController == null) return;

    final p = _videoController!.value.position;
    final d = _videoController!.value.duration;

    if (p.inMilliseconds == 0 || d.inMilliseconds == 0) return;

    final newProgress = p.inMilliseconds / d.inMilliseconds;

    if (newProgress != _progress) {
      setState(() {
        _progress = newProgress;
        _canComplete = newProgress >= 0.8;
      });
    }
  }

  @override
  void dispose() {
    widget.tabController.removeListener(_tabListener);
    _videoController?.removeListener(_handleVideoProgress);
    _chewieController?.dispose();
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // IMPORTANT
    if (_isLoading) return const Center(child: CircularProgressIndicator());
    if (_hasError || _chewieController == null) return _buildFallback();

    return _buildVideoPlayer();
  }

  Widget _buildVideoPlayer() {
    return SingleChildScrollView(
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: _videoController!.value.aspectRatio,
            child: Chewie(controller: _chewieController!),
          ),
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.step.title.isNotEmpty)
                  AppText.title3(
                    widget.step.title,
                    color: context.colors.fgDefault,
                    maxLines: 2,
                  ),

                SizedBox(height: 16.h),

                if (widget.step.text?.isNotEmpty == true)
                  Text(
                    widget.step.text!,
                    style: TextStyle(fontSize: 15.sp),
                  ),

                const SizedBox(height: 16),

                MarkAsCompleteButton(
                  // status: _canComplete ? widget.step.status : "NOT_READY",
                  status: widget.step.status,
                  markAsComplete: () {
                    // if (_canComplete) {
                    widget.markAsComplete();
                    // }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFallback() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.videocam_off, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          const Text("Video not available"),
          const SizedBox(height: 16),
          MarkAsCompleteButton(
            status: widget.step.status,
            canComplete: true,
            markAsComplete: () {
              widget.markAsComplete();
            },
          ),
        ],
      ),
    );
  }
}
