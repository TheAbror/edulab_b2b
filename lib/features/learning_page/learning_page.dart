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

  void _initTabController(List<StepModel> steps) {
    _tabController?.dispose();
    _tabController = TabController(length: steps.length, vsync: this);

    /// Sync UI → BLoC
    _tabController!.addListener(() {
      if (!_tabController!.indexIsChanging) {
        context.read<LearningPageBloc>().changeTabIndex(_tabController!.index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LearningPageBloc()..resumeCourseById(widget.id),
      child: BlocBuilder<LearningPageBloc, LearningPageState>(
        builder: (context, state) {
          if (state.blocProgress == BlocProgress.IS_LOADING) {
            return Scaffold(
              backgroundColor: context.colors.bgPage1,
              body: const Center(child: CircularProgressIndicator()),
            );
          }

          final chapterID = state.chapterID;
          final topicID = state.topicID;
          final stepID = state.stepID;

          // --- Find the chapter safely ---
          final chapter = state.resumedCourse.chapters.firstWhere(
            (c) => c.id == chapterID,
            orElse: () => ChapterModel.initial(),
          );

          // --- Find the topic safely ---
          final topic = chapter.topics.firstWhere(
            (t) => t.id == topicID,
            orElse: () => TopicModel.initial(),
          );

          // --- Steps for the tab controller ---
          final steps = topic.steps.isNotEmpty
              ? topic.steps
              : [StepModel.initial()];

          // --- Initialize TabController when needed ---
          if (_tabController == null ||
              _tabController!.length != steps.length) {
            _initTabController(steps);
          }

          // --- Move to the correct step index ---
          final initialIndex = steps.indexWhere((s) => s.id == stepID);
          _tabController!.index = initialIndex == -1 ? 0 : initialIndex;

          // --- Build UI ---
          return Scaffold(
            backgroundColor: context.colors.bgPage1,
            appBar: LearningResumeCourseAppBar(
              state: state,
              controller: _tabController!,
              title: topic.title,
              steps: steps,
            ),
            body: _Body(
              steps: steps,
              controller: _tabController!,
              chapterID: chapter.id,
              stepID: stepID,
              topicID: topic.id,
            ),
            bottomNavigationBar: state.isExpanded
                ? const SizedBox()
                : LearningBottomNavigation(
                    controller: _tabController!,
                    stepsLength: steps.length,
                  ),
          );
        },
      ),
    );
  }
}

class _Body extends StatefulWidget {
  final List<StepModel> steps;
  final TabController controller;
  final int chapterID;
  final int topicID;
  final int stepID;

  const _Body({
    required this.steps,
    required this.controller,
    required this.chapterID,
    required this.topicID,
    required this.stepID,
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

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: widget.controller,
      physics: const BouncingScrollPhysics(),
      children: widget.steps.map(
        (step) {
          switch (step.type) {
            case 'TEXT':
              return LearningPageTextTab(
                step: step,
                markAsComplete: () =>
                    context.read<LearningPageBloc>().completeStep(
                      chapterID: widget.chapterID,
                      topicID: widget.topicID,
                      stepID: widget.stepID,
                    ),
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
                      Icon(Icons.videocam_off, size: 64, color: Colors.grey),
                      SizedBox(height: 16),
                      Text('Video not available'),
                      MarkAsCompleteButton(
                        markAsComplete: () =>
                            context.read<LearningPageBloc>().completeStep(
                              chapterID: widget.chapterID,
                              topicID: widget.topicID,
                              stepID: widget.stepID,
                            ),
                      ),
                    ],
                  ),
                );
              }
            case 'QUIZ':
              return LearningPageQuizTab(
                step: step,

                markAsComplete: () =>
                    context.read<LearningPageBloc>().completeStep(
                      chapterID: widget.chapterID,
                      topicID: widget.topicID,
                      stepID: widget.stepID,
                    ),
              );
            default:
              return SingleChildScrollView(child: Text(step.title));
          }
        },
      ).toList(),
    );
  }
}
