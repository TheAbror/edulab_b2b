import 'package:leti_mobile/widget_imports.dart';

class CourseContentTabInfo extends StatelessWidget {
  final int id;
  const CourseContentTabInfo({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<SingleCourseBloc>().getSingleCourse(id);
      },
      child: ListView(
        padding: EdgeInsets.zero,
        physics: AlwaysScrollableScrollPhysics(),
        children: [
          SingleCourseBody(isContent: true, id: id),
        ],
      ),
    );
  }
}
