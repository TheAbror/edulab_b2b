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

                    // "Courses you're currently taking": driven by
                    // course/own?status=IN_PROGRESS (LearningTabBloc.inProgress).
                    // Show the resume carousel when the learner has enrolled
                    // courses in progress, otherwise the empty state.
                    BlocBuilder<LearningTabBloc, LearningTabState>(
                      builder: (context, learningState) {
                        final inProgress = learningState.inProgress;

                        // Don't flash the empty state while the first fetch is
                        // still running for a signed-in user.
                        final waitingForFirstLoad = isAuthorized == true &&
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
                            padding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 24.h),
                            child: HomeNoAssignedCoursesWidget(
                              onTap: () {
                                context.read<HomeBloc>().changeTabIndex(1);
                              },
                            ),
                          );
                        }

                        return Padding(
                          padding: EdgeInsets.only(top: 8.h, bottom: 24.h),
                          child: SizedBox(
                            height: 226.h,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.only(left: 8.w),
                              itemCount: inProgress.length,
                              itemBuilder: (context, index) {
                                final item = inProgress[index];

                                return HomeMyStudyWidget(
                                  width: inProgress.length == 1 ? 350.w : 330.w,
                                  title: item.title,
                                  image: item.thumbnail?.originalUrl ?? '',
                                  progress: item.progess,
                                  buttonText:
                                      context.localizations.continueButton,
                                  continueCourse: () {
                                    Navigator.pushNamed(
                                      context,
                                      AppRoutes.learningPage,
                                      arguments: OpenCourseByTopicSelectionModel(
                                        courseID: item.id,
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
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
