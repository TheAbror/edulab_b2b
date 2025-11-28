import 'package:leti_mobile/widget_imports.dart';

class CourseContentTabMaterials extends StatelessWidget {
  final SingleCourseState state;

  const CourseContentTabMaterials({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 24.h),
      itemCount: state.fullCourseInfo.syllabus?.courseContent?.length,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final title = state.fullCourseInfo.syllabus?.courseContent?[index];

        return CourseInfoMaterialExpansionItem(
          title: title?.title ?? '',
          subTitle: title?.description ?? '',
          chapterInfoText: title?.topics.map((e) => e.title).toList() ?? [],
          lessonsLength: title?.topics.length ?? 0,
          topics: title?.topics ?? [],
        );
      },
    );
  }
}
