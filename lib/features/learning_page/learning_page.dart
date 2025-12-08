import 'package:leti_mobile/widget_imports.dart';

class LearningPage extends StatefulWidget {
  final OpenCourseByTopicSelectionModel args;

  const LearningPage({
    super.key,
    required this.args,
  });

  @override
  State<LearningPage> createState() => _LearningPageState();
}

class _LearningPageState extends State<LearningPage>
    with TickerProviderStateMixin {
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
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LearningBloc()
        ..resumeCourseById(
          id: widget.args.courseID,
          currentlyActive: widget.args.ids,
        ),
      child: BlocBuilder<LearningBloc, LearningState>(
        builder: (context, state) {
          if (state.blocProgress == BlocProgress.IS_LOADING) {
            return Scaffold(
              backgroundColor: context.colors.bgPage1,
              body: const Center(child: CircularProgressIndicator()),
            );
          }
          if (state.allSteps.isEmpty) {
            return Scaffold(
              backgroundColor: context.colors.bgPage1,
              body: const Center(child: Text('No results')),
            );
          }

          if (_tabController == null ||
              _tabController!.length != state.allSteps.length) {
            _initTabController(
              state.step,
              state.allSteps,
            );
          }

          return Scaffold(
            backgroundColor: context.colors.bgPage1,
            appBar: LearningResumeCourseAppBar(
              state: state,
              controller: _tabController!,
              title: state.topic.title,
              steps: state.allSteps,
            ),
            body: LearningPageBody(
              steps: state.allSteps,
              controller: _tabController!,
            ),
            bottomNavigationBar: state.isExpanded
                ? const SizedBox()
                : LearningBottomNavigation(
                    controller: _tabController!,
                    stepsLength: state.allSteps.length,
                    status: state.allSteps[state.appbarTabIndex].status,
                    stepModel: state.allSteps[state.appbarTabIndex],
                  ),
          );
        },
      ),
    );
  }
}
