import 'package:edulab_b2b/widget_imports.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  // Re-fetches everything the tab shows; wired to pull-to-refresh. The initial
  // load is kicked off by RootPage.
  void myInit() {
    final bool? isAuthorized = PreferencesServices.getAuthStatus();

    if (isAuthorized == true) {
      context.read<CoursesBloc>().getAllCourses();
      context.read<LearningTabBloc>().getInProgress();
      context.read<LearningTabBloc>().getCompleted();
      context.read<LearningTabBloc>().getStatistics();
    } else {
      context.read<CoursesBloc>().getAllCoursesAsUnauthorized();
    }
  }

  bool isConnectedAgain = false;
  final bool? isAuthorized = PreferencesServices.getAuthStatus();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoursesBloc, CoursesState>(
      builder: (context, state) {
        if (state.blocProgress == BlocProgress.IS_LOADING) {
          return Center(child: CircularProgressIndicator());
        }

        return RefreshIndicator(
          onRefresh: () async {
            myInit();
          },
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, homeState) {
              return ColoredBox(
                color: context.colors.bgPage3,
                child: ListView(
                  children: [
                    HomeTabAppBar(),

                    // My STUDY
                    BlocBuilder<LearningTabBloc, LearningTabState>(
                      builder: (context, learningState) {
                        final inProgress = learningState.inProgress;

                        // Don't flash the empty state while the first fetch is
                        // still running for a signed-in user.
                        final waitingForFirstLoad =
                            isAuthorized == true &&
                            inProgress.isEmpty &&
                            (learningState.blocProgress ==
                                    BlocProgress.NOT_STARTED ||
                                learningState.blocProgress ==
                                    BlocProgress.IS_LOADING);

                        if (waitingForFirstLoad) {
                          return const SizedBox.shrink();
                        }

                        if (inProgress.isEmpty) {
                          return Padding(
                            padding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 0.h),
                            child: HomeNoAssignedCoursesWidget(
                              onTap: () {
                                context.read<HomeBloc>().changeTabIndex(1);
                              },
                            ),
                          );
                        }

                        return Padding(
                          padding: EdgeInsets.only(top: 8.h),
                          child: HomeMyStudySection(
                            courses: inProgress,
                            onShowAll: () {
                              context.read<HomeBloc>().changeTabIndex(1);
                            },
                            onContinue: (course) {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.learningPage,
                                arguments: OpenCourseByTopicSelectionModel(
                                  courseID: course.id,
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),

                    if (state.coursesAll.isNotEmpty)
                      OurCoursesWidget(courses: state.coursesAll),
                    space24,
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
