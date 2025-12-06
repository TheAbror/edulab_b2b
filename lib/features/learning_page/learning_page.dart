// ignore_for_file: unnecessary_null_comparison

import 'package:leti_mobile/features/learning_page/tabs/learning_quiz_tab.dart';
import 'package:leti_mobile/widget_imports.dart';

class LearningPage extends StatefulWidget {
  final int id;

  const LearningPage({super.key, required this.id});

  @override
  State<LearningPage> createState() => _LearningPageState();
}

class _LearningPageState extends State<LearningPage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  void _initTabController(
    StepModel step,
    List<StepModel> allSteps,
  ) {
    final initialIndex = allSteps.indexWhere((s) => s.id == step.id);
    _tabController?.dispose();

    _tabController = TabController(
      length: allSteps.length,
      vsync: this,
      initialIndex: initialIndex != -1 ? initialIndex : 0,
    );

    _tabController!.addListener(() {
      if (!_tabController!.indexIsChanging) {
        final newIndex = _tabController!.index;
        final stepID = allSteps[newIndex].id;
        context.read<LearningBloc>().manageSteps(
          stepID,
          allSteps[newIndex],
        );
        context.read<LearningBloc>().appBarTabIndex(newIndex);
      }
    });
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LearningBloc()..resumeCourseById(widget.id),
      child: BlocBuilder<LearningBloc, LearningState>(
        builder: (context, state) {
          if (state.blocProgress == BlocProgress.IS_LOADING) {
            return Scaffold(
              backgroundColor: context.colors.bgPage1,
              body: const Center(child: CircularProgressIndicator()),
            );
          }

          if (_tabController == null ||
              _tabController!.length != state.allSteps.length) {
            _initTabController(
              state.step,
              state.allSteps,
            );
          }

          final currentStep = state
              .allSteps[_tabController?.index ?? state.currentTabIndex]
              .status;

          return Scaffold(
            backgroundColor: context.colors.bgPage1,
            appBar: LearningResumeCourseAppBar(
              state: state,
              controller: _tabController!,
              title: state.topic.title,
              steps: state.allSteps,
            ),
            body: _Body(
              steps: state.allSteps,
              controller: _tabController!,
            ),
            bottomNavigationBar: state.isExpanded
                ? const SizedBox()
                : LearningBottomNavigation(
                    controller: _tabController!,
                    stepsLength: state.allSteps.length,
                    status: currentStep,
                  ),
          );
        },
      ),
    );
  }
}

class _Body extends StatefulWidget {
  final TabController controller;
  final List<StepModel> steps;

  const _Body({
    required this.controller,
    required this.steps,
  });

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
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

  void completeStep(
    int chapterID,
    int topicID,
    int stepID,
  ) {
    context.read<LearningBloc>().completeStep(
      chapterID: chapterID,
      topicID: topicID,
      stepID: stepID,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LearningBloc, LearningState>(
      builder: (context, state) {
        return TabBarView(
          controller: widget.controller,
          physics: const BouncingScrollPhysics(),
          children: widget.steps.map(
            (step) {
              switch (step.type) {
                case 'TEXT':
                  return LearningPageTextTab(
                    step: step,
                    markAsComplete: () {
                      step.status == "COMPLETED"
                          ? () {}
                          : completeStep(
                              state.chapterID,
                              state.topicID,
                              state.stepID,
                            );
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
                                  : completeStep(
                                      state.chapterID,
                                      state.topicID,
                                      state.stepID,
                                    );
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
                      step.status == "COMPLETED"
                          ? () {}
                          : completeStep(
                              state.chapterID,
                              state.topicID,
                              state.stepID,
                            );
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
