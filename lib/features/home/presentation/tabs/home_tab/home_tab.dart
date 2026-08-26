import 'package:edulab_b2b/widget_imports.dart';

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
              return ColoredBox(
                color: context.colors.bgPage3,
                child: ListView(
                  children: [
                    HomeTabAppBar(),

                    // BlocBuilder<LearningTabBloc, LearningTabState>(
                    //   builder: (context, learningState) {
                    //     final inProgressList = learningState.inProgress;

                    //     if (inProgressList.isEmpty) {
                    //       return SizedBox.shrink();
                    //     }

                    //     return Container(
                    //       height: 226.h,
                    //       color: context.colors.accentContainerDefault
                    //           .withOpacity(0.1),
                    //       child: Column(
                    //         children: [
                    //           Expanded(
                    //             child: ListView.builder(
                    //               scrollDirection: Axis.horizontal,
                    //               padding: EdgeInsets.only(left: 8.w),
                    //               itemCount: inProgressList.length,
                    //               itemBuilder: (context, index) {
                    //                 final item = inProgressList[index];

                    //                 return HomeMyStudyWidget(
                    //                   width: inProgressList.length == 1
                    //                       ? 350.w
                    //                       : 330.w,
                    //                   title: item.title,
                    //                   image: item.thumbnail?.originalUrl ?? '',
                    //                   progress: item.progess,
                    //                   buttonText:
                    //                       context.localizations.continueButton,
                    //                   continueCourse: () {
                    //                     Navigator.pushNamed(
                    //                       context,
                    //                       AppRoutes.learningPage,
                    //                       arguments:
                    //                           OpenCourseByTopicSelectionModel(
                    //                             courseID: item.id,
                    //                           ),
                    //                     );
                    //                   },
                    //                 );
                    //               },
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     );
                    //   },
                    // ),
                    if (isAuthorized == null)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: HomeNoAssignedCoursesWidget(
                          onTap: () {
                            context.read<HomeBloc>().changeTabIndex(1);
                          },
                        ),
                      ),
                    if (isAuthorized == null) space24,

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
