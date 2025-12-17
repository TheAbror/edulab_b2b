import 'package:leti_mobile/widget_imports.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
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
            context.read<CoursesBloc>().getCurrentCourse();
          },
          child: ListView(
            children: [
              HomeTabAppBar(),

              if (currentCourse.isNotEmpty)
                HomeMyStudyWidget(
                  title: currentCourse.first.title,
                  image: currentCourse.first.thumbnail?.original_url ?? '',
                  progress: currentCourse.first.progess,
                  // progress: 0,
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
                    Navigator.pushNamed(context, AppRoutes.allCoursesPage);
                  },
                ),

              space24,
              if (state.coursesAll.isNotEmpty)
                RecommendedCourses(
                  courses: state.coursesAll,
                  onTapViewAll: () {
                    Navigator.pushNamed(context, AppRoutes.allCoursesPage);
                  },
                ),
              space24,

              if (state.categories.isNotEmpty)
                HomeCategoriesList(
                  viewAllOnTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.allCategoriesPage,
                    );
                  },
                ),
              HomeLearnNewSkillsWidget(
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.allCoursesPage);
                },
              ),
              space24,
            ],
          ),
        );
      },
    );
  }
}
