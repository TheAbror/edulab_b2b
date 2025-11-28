import 'package:leti_mobile/features/home/presentation/tabs/learning_tab/learning_page/bloc/learning_tab_bloc.dart';
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

  void _loadVideo(String url) {
    if (url.isEmpty) return;

    setState(() => _isVideoLoading = true);

    _videoPlayerController?.dispose();
    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(url))
      ..initialize()
          .then((_) {
            if (mounted) {
              setState(() => _isVideoLoading = false);
              _videoPlayerController?.play();
            }
          })
          .catchError((_) {
            if (mounted) setState(() => _isVideoLoading = false);
          });
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: widget.controller,
      physics: const BouncingScrollPhysics(),
      children: widget.steps.map((step) {
        switch (step.type) {
          case 'TEXT':
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Text(step.text ?? ''),
            );
          case 'VIDEO':
            if (_isVideoLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            final controller = _videoPlayerController;
            if (controller != null && controller.value.isInitialized) {
              return Column(
                children: [
                  AspectRatio(
                    aspectRatio: controller.value.aspectRatio,
                    child: VideoPlayer(controller),
                  ),
                  Text(step.text ?? ''),
                ],
              );
            } else {
              return const Center(child: Text('Video not available'));
            }
          case 'QUIZ':
            return SingleChildScrollView(child: Text("Quiz step"));
          default:
            return SingleChildScrollView(child: Text(step.title));
        }
      }).toList(),
    );
  }
}

class AppBarItem extends StatelessWidget {
  final double? height;
  final String text;

  const AppBarItem({super.key, required this.text, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 28.h,
      alignment: Alignment.center,
      child: AppText.paragraph1(
        text.length > 15 ? '${text.substring(0, 15)}...' : text,
      ),
    );
  }
}
