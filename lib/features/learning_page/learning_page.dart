import 'package:chewie/chewie.dart';
import 'package:leti_mobile/features/learning_page/bloc/learning_tab_bloc.dart';
import 'package:leti_mobile/widget_imports.dart';

// import 'package:chewie/chewie.dart';/
import 'package:video_player/video_player.dart';

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

          // final steps = state.resumedCourse.chapters.where((e) => e.id == widget.id).first.topics;
          final steps = state.resumedCourse.chapters.first.topics.first.steps;

          if (_tabController == null ||
              _tabController!.length != steps.length) {
            _initTabController(steps);
          }

          return DefaultTabController(
            length: steps.length,
            child: Scaffold(
              backgroundColor: context.colors.bgPage1,
              appBar: LearningResumeCourseAppBar(
                state: state,
                controller: _tabController!,
                title: state.resumedCourse.chapters.first.title,
              ),
              bottomNavigationBar: state.isExpanded
                  ? const SizedBox()
                  : LearningBottomNavigation(),
              body: _Body(steps: steps, controller: _tabController!),
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

  const _Body({required this.steps, required this.controller});

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
              return LearningPageTextTab(step: step);
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
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.videocam_off, size: 64, color: Colors.grey),
                      SizedBox(height: 16),
                      Text('Video not available'),
                    ],
                  ),
                );
              }
            case 'QUIZ':
              return SingleChildScrollView(child: Text("Quiz step"));
            default:
              return SingleChildScrollView(child: Text(step.title));
          }
        },
      ).toList(),
    );
  }
}

class LearningPageVideoTab extends StatelessWidget {
  final ChewieController? chewieController;
  final StepModel step;

  const LearningPageVideoTab({
    super.key,
    required this.chewieController,
    required this.step,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Chewie(controller: chewieController!),
          ),

          const SizedBox(height: 16),

          // Video title
          if (step.title.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                step.title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

          const SizedBox(height: 16),

          // Video description
          if (step.text?.isNotEmpty == true)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                step.text!,
                style: TextStyle(fontSize: 16),
              ),
            ),

          const SizedBox(height: 16),

          // Additional widgets can be added here
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.info, color: Colors.blue),
                SizedBox(width: 8),
                Text('Additional information'),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Example buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('Like'),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: Text('Share'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LearningPageTextTab extends StatelessWidget {
  const LearningPageTextTab({
    super.key,
    required this.step,
  });

  final StepModel step;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(step.text ?? ''),
          Text('data'),
        ],
      ),
    );
  }
}
