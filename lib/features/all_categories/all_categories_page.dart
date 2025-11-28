import 'package:leti_mobile/widget_imports.dart';

class AllCategoriesPage extends StatefulWidget {
  const AllCategoriesPage({super.key});

  @override
  State<AllCategoriesPage> createState() => _AllCategoriesPageState();
}

class _AllCategoriesPageState extends State<AllCategoriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: BlocBuilder<CoursesBloc, CoursesState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SearchAndFilter(),
                  space24,
                  GridView.builder(
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
                          Navigator.pushNamed(
                            context,
                            AppRoutes.allCoursesPage,
                            arguments: IdAndTitle(
                              id: item.id,
                              title: item.title,
                            ),
                          );
                        },
                        text: item.title,
                        // count:
                        //     '${item.courseCount}  ${context.localizations.coursesWithnumber}',
                        count: 'dfsfsdd',
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomAppBarBackButton(),
          SizedBox(width: 8.w),
          Text(
            context.localizations.allCategories,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
