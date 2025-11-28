import 'package:leti_mobile/widget_imports.dart';

class HomeCategoriesList extends StatelessWidget {
  final VoidCallback viewAllOnTap;

  const HomeCategoriesList({super.key, required this.viewAllOnTap});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoursesBloc, CoursesState>(
      builder: (context, state) {
        if (state.categories.isEmpty) {
          return SizedBox();
        }

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              HeadlineAndViewAllWidget(
                text: context.localizations.softSkills,
                viewAllOnTap: viewAllOnTap,
              ),
              space16,
              if (state.categories.isNotEmpty)
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.categories.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final item = state.categories[index];

                    return HomeCourseItem(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.allCoursesPage,
                          arguments: IdAndTitle(id: item.id, title: item.title),
                        );
                      },
                      text: item.title,
                      count: 'njhkgf',
                      // count:
                      //     '${item.courseCount} ${context.localizations.coursesWithnumber}',
                    );
                  },
                ),
              SizedBox(height: 30.h),
            ],
          ),
        );
      },
    );
  }
}
