import 'package:edulab_b2b/widget_imports.dart';

class CoursesTab extends StatelessWidget {
  const CoursesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.bgPage3,
      body: _Body(),
    );
  }
}

class _Body extends StatefulWidget {
  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  int? _selectedCategoryId;
  String _searchQuery = '';

  List<CategoryModel> _extractCategories(List<CourseShortInfo> courses) {
    final seenIds = <int>{};
    final categories = <CategoryModel>[];

    for (final course in courses) {
      final category = course.category;
      if (category.title.isNotEmpty && seenIds.add(category.id)) {
        categories.add(category);
      }
    }

    return categories;
  }

  List<CourseShortInfo> _filterCourses(List<CourseShortInfo> courses) {
    final query = _searchQuery.trim().toLowerCase();

    return courses.where((course) {
      final matchesCategory =
          _selectedCategoryId == null ||
          course.category.id == _selectedCategoryId;
      final matchesQuery =
          query.isEmpty || course.title.toLowerCase().contains(query);

      return matchesCategory && matchesQuery;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder<CoursesBloc, CoursesState>(
        builder: (context, state) {
          final categories = _extractCategories(state.coursesAll);
          final filteredCourses = _filterCourses(state.coursesAll);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                child: SearchAndFilter(
                  onChanged: (value) => setState(() => _searchQuery = value),
                ),
              ),
              space12,
              if (categories.isNotEmpty)
                CourseCategoryChips(
                  categories: categories,
                  selectedCategoryId: _selectedCategoryId,
                  onSelected: (categoryId) =>
                      setState(() => _selectedCategoryId = categoryId),
                ),
              space12,

              if (filteredCourses.isNotEmpty)
                CourseListCard(courses: filteredCourses),

              space40,
            ],
          );
        },
      ),
    );
  }
}
