import 'package:leti_mobile/widget_imports.dart';

class LearningPageBody extends StatefulWidget {
  final TabController controller;
  final List<StepModel> steps;

  const LearningPageBody({
    super.key,
    required this.controller,
    required this.steps,
  });

  @override
  State<LearningPageBody> createState() => LearningPageBodyState();
}

class LearningPageBodyState extends State<LearningPageBody> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  bool _isVideoLoading = false;

  @override
  void initState() {
    super.initState();
    _initializeFirstVideo();
  }

  void _initializeFirstVideo() {
    final videoStep = widget.steps.firstWhere(
      (step) => step.type == 'VIDEO' && step.media?.original_url != null,
      orElse: () => widget.steps[0],
    );

    _loadVideo(videoStep.media?.original_url ?? "");
  }

  void _loadVideo(String url) async {
    if (url.isEmpty) return;

    setState(() => _isVideoLoading = true);

    // Dispose previous controllers
    _chewieController?.dispose();
    _videoPlayerController?.dispose();

    try {
      _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(url));

      // Initialize video player
      await _videoPlayerController!.initialize();

      // Create Chewie controller
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController!,
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
        autoInitialize: true,
      );

      if (mounted) {
        setState(() => _isVideoLoading = false);
      }
    } catch (error) {
      if (mounted) {
        setState(() => _isVideoLoading = false);
      }
      print('Error loading video: $error');
    }
  }

  @override
  void dispose() {
    _chewieController?.dispose();
    _videoPlayerController?.dispose();
    super.dispose();
  }

  void completeStep(StepModel stepModel) {
    context.read<LearningBloc>().completeStep(stepModel);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LearningBloc, LearningState>(
      builder: (context, state) {
        return TabBarView(
          controller: widget.controller,
          physics: const BouncingScrollPhysics(),
          children: state.allSteps.map(
            (step) {
              switch (step.type) {
                case 'TEXT':
                  return LearningPageTextTab(
                    step: step,
                    markAsComplete: () {
                      step.status == "COMPLETED" ? () {} : completeStep(step);
                    },
                  );
                case 'VIDEO':
                  if (_isVideoLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (_chewieController != null &&
                      _videoPlayerController != null &&
                      _videoPlayerController!.value.isInitialized) {
                    return LearningPageVideoTab(
                      step: step,
                      chewieController: _chewieController,
                    );
                  } else {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.videocam_off,
                            size: 64,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 16),
                          Text('Video not available'),
                          MarkAsCompleteButton(
                            status: step.status,
                            markAsComplete: () {
                              step.status == "COMPLETED"
                                  ? () {}
                                  : completeStep(step);
                            },
                          ),
                        ],
                      ),
                    );
                  }
                case 'QUIZ':
                  return LearningPageQuizTab(
                    step: step,
                    markAsComplete: () {
                      step.status == "COMPLETED" ? () {} : completeStep(step);
                    },
                  );
                default:
                  return SingleChildScrollView(child: Text(step.title));
              }
            },
          ).toList(),
        );
      },
    );
  }
}
