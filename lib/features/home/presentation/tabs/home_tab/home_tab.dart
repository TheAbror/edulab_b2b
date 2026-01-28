import 'package:leti_mobile/features/home/presentation/widgets/no_internet_widget.dart';
import 'package:leti_mobile/widget_imports.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  void myInit() {
    context.read<CoursesBloc>().getAllCategories();
    context.read<CoursesBloc>().getHomeCourses();
    context.read<CoursesBloc>().getCurrentCourse();
    context.read<LearningTabBloc>().getInProgress();
    context.read<LearningTabBloc>().getCompleted();
    context.read<LearningTabBloc>().getStatistics();
  }

  bool isConnectedAgain = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoursesBloc, CoursesState>(
      builder: (context, state) {
        if (state.blocProgress == BlocProgress.IS_LOADING) {
          return Center(child: CircularProgressIndicator());
        }

        final currentCourse = state.currentCourse;

        return RefreshIndicator(
          onRefresh: () async {
            myInit();
          },
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, homeState) {
              if (state.blocProgress != BlocProgress.IS_LOADING &&
                  homeState.internetStatus == InternetStatus.disconnected) {
                return NoInternetView();
              }
              if (homeState.internetStatus == InternetStatus.connected &&
                  !isConnectedAgain) {
                myInit();
                isConnectedAgain = true;
              }

              return ListView(
                children: [
                  HomeTabAppBar(),

                  if (currentCourse.isNotEmpty)
                    HomeMyStudyWidget(
                      title: currentCourse.first.title,
                      image: currentCourse.first.thumbnail?.original_url ?? '',
                      progress: currentCourse.first.progess,
                      buttonText: context.localizations.continueButton,
                      continueCourse: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.learningPage,
                          arguments: OpenCourseByTopicSelectionModel(
                            courseID: currentCourse.first.id,
                          ),
                        );
                      },
                      viewAllOnTap: () {
                        context.read<HomeBloc>().changeTabIndex(1);
                      },
                    )
                  else
                    HomeFindSomethingToLearnWidget(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.allCoursesPage,
                        );
                      },
                    ),

                  space24,
                  if (state.homeCourses.content.isNotEmpty)
                    OurCoursesWidget(
                      courses: state.homeCourses,
                      onTapViewAll: () {
                        Navigator.pushNamed(context, AppRoutes.allCoursesPage);
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
