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

        final item = state.coursesAll;
        final currentCourse = state.currentCourse;

        return ListView(
          children: [
            HomeTabAppBar(),

            if (currentCourse.isNotEmpty)
              HomeMyStudyWidget(
                title: currentCourse.first.title,
                image: currentCourse.first.thumbnail?.original_url ?? '',
                // progress: currentCourse.first.overallProgress ?? 0,
                progress: 0,
                buttonText: context.localizations.continueButton,
                continueCourse: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.learningPage,
                    arguments: currentCourse.first.id,
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
              RecommendedForYou(
                length: item.length,
                onTapViewAll: () {
                  Navigator.pushNamed(context, AppRoutes.allCoursesPage);
                },
                openThisCourse: (int id) async {
                  final bool? result = await context
                      .read<CoursesBloc>()
                      .checkEnrollment(id);

                  if (!context.mounted) return;

                  if (result != null) {
                    Navigator.pushNamed(
                      context,

                      result
                          ? AppRoutes.enrolledCoursePage
                          : AppRoutes.singleCoursePage,
                      arguments: id,
                    );
                  }
                },
                imageUrl: item
                    .map((e) => e.thumbnail?.original_url ?? '')
                    .toList(),
                title: item.map((e) => e.title).toList(),
                subTitle: item.map((e) => e.short_description).toList(),
                indexes: item.map((e) => e.id).toList(),
                // isCertificateAvailble: item.map((e) => e.certificate).toList(),
                price: const [0.0],
              ),
            space24,
            // HomeAuthorsList(
            //   viewAllOnTap: () {},
            // ),
            if (state.categories.isNotEmpty)
              HomeCategoriesList(
                viewAllOnTap: () {
                  Navigator.pushNamed(context, AppRoutes.allCategoriesPage);
                },
              ),
            HomeLearnNewSkillsWidget(
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.allCoursesPage);
              },
            ),
            space24,
          ],
        );
      },
    );
  }
}
