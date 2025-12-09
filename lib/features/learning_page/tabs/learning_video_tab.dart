import 'package:leti_mobile/widget_imports.dart';

class LearningPageVideoTab extends StatefulWidget {
  final StepModel step;
  final VoidCallback markAsComplete;

  const LearningPageVideoTab({
    super.key,
    required this.step,
    required this.markAsComplete,
  });

  @override
  State<LearningPageVideoTab> createState() => _LearningPageVideoTabState();
}

class _LearningPageVideoTabState extends State<LearningPageVideoTab> {
  VideoPlayerController? _videoController;
  ChewieController? _chewieController;

  bool _isLoading = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    final url = widget.step.media?.original_url ?? "";

    if (url.isEmpty) {
      setState(() => _hasError = true);
      return;
    }

    setState(() => _isLoading = true);

    try {
      _videoController = VideoPlayerController.networkUrl(Uri.parse(url));
      await _videoController!.initialize();

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

  @override
  void dispose() {
    _chewieController?.dispose();
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_hasError || _chewieController == null) {
      return _buildFallback();
    }

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
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                if (widget.step.title.isNotEmpty)
                  Text(
                    widget.step.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                const SizedBox(height: 16),

                if (widget.step.text?.isNotEmpty == true)
                  Text(
                    widget.step.text!,
                    style: const TextStyle(fontSize: 16),
                  ),

                const SizedBox(height: 16),

                MarkAsCompleteButton(
                  status: widget.step.status,
                  markAsComplete: widget.markAsComplete,
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
            markAsComplete: widget.markAsComplete,
          ),
        ],
      ),
    );
  }
}
