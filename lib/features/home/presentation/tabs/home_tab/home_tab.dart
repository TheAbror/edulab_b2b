import 'package:leti_mobile/widget_imports.dart';

//TODO check no result case in matematika start
//probably backend problem
class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

//
class _HomeTabState extends State<HomeTab> {
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
              return ListView(
                children: [
                  HomeTabAppBar(),

                  BlocBuilder<LearningTabBloc, LearningTabState>(
                    builder: (context, learningState) {
                      final inProgressList = learningState.inProgress;

                      if (inProgressList.isEmpty) {
                        return SizedBox.shrink();
                      }

                      return Container(
                        height: 226.h,
                        color: context.colors.accentContainerDefault
                            .withOpacity(0.1),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(16.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    context.localizations.myStudy,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      letterSpacing: -1,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      context.read<HomeBloc>().changeTabIndex(
                                        1,
                                      );
                                    },
                                    behavior: HitTestBehavior.opaque,
                                    child: Text(
                                      context.localizations.viewAll,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Expanded(
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                padding: EdgeInsets.only(left: 8.w),
                                itemCount: inProgressList.length,
                                itemBuilder: (context, index) {
                                  final item = inProgressList[index];

                                  return HomeMyStudyWidget(
                                    width: inProgressList.length == 1
                                        ? 350.w
                                        : 330.w,
                                    title: item.title,
                                    image: item.thumbnail?.originalUrl ?? '',
                                    progress: item.progess,
                                    buttonText:
                                        context.localizations.continueButton,
                                    continueCourse: () {
                                      Navigator.pushNamed(
                                        context,
                                        AppRoutes.learningPage,
                                        arguments:
                                            OpenCourseByTopicSelectionModel(
                                              courseID: item.id,
                                            ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  if (isAuthorized == null)
                    HomeFindSomethingToLearnWidget(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.loginPage,
                        );
                      },
                    ),
                  if (isAuthorized == null) space24,

                  if (state.coursesAll.isNotEmpty)
                    OurCoursesWidget(
                      isViewAllNeeded: false,
                      courses: state.coursesAll,
                      onTapViewAll: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.allCoursesPage,
                        );
                      },
                    ),
                  space24,
                ],
              );
            },
          ),
        );
      },
    );
  }
}
