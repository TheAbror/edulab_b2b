import 'package:leti_mobile/widget_imports.dart';

class CoursesTab extends StatelessWidget {
  const CoursesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _Body());
  }
}

class _Body extends StatefulWidget {
  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: BlocBuilder<CoursesBloc, CoursesState>(
          builder: (context, state) {
            final item = state.coursesAll;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CourseTabBanner(),
                space40,
                RecommendedForYou(
                  length: item.length,
                  onTapViewAll: () {
                    Navigator.pushNamed(context, AppRoutes.allCoursesPage);
                  },
                  singleCourseBlocProgress: state.singleCourseBlocProgress,
                  openThisCourse: (int id) {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.singleCoursePage,
                      arguments: id,
                    );
                  },
                  imageUrl: item
                      .map((e) => e.thumbnail?.original_url ?? '')
                      .toList(),
                  title: item.map((e) => e.title).toList(),
                  subTitle: item.map((e) => e.short_description).toList(),
                  indexes: item.map((e) => e.id).toList(),
                ),
                space40,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    context.localizations.categories,
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -1,
                    ),
                  ),
                ),
                space16,
                state.categories.isNotEmpty
                    ? GridView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 160.w,
                          childAspectRatio: 6 / 3.3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: state.categories.length,
                        itemBuilder: (context, index) {
                          final item = state.categories[index];
                          return CourseTabItem(
                            onTap: () {
                              // Navigator.pushNamed(context,AppRoutes.courseSubcategoryPage);
                            },
                            text: item.title,
                            // count:
                            //     '${item.courseCount} ${context.localizations.coursesWithnumber}',
                            count: '234234',
                          );
                        },
                      )
                    : SizedBox.shrink(),
                space20,
                CourseInfoShowAllButton(
                  isPaddingNeeded: true,
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.allCategoriesPage);
                  },
                ),
                space40,
              ],
            );
          },
        ),
      ),
    );
  }
}
