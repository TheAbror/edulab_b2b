import 'package:edulab_b2b/widget_imports.dart';

class HomeMyStudyWidget extends StatelessWidget {
  final String title;
  final int progress;
  final String buttonText;
  final String image;
  final VoidCallback continueCourse;
  final double width;

  const HomeMyStudyWidget({
    super.key,
    required this.title,
    required this.progress,
    required this.buttonText,
    required this.image,
    required this.continueCourse,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: EdgeInsets.only(
        left: 0.w,
        right: 8.w,
        bottom: 14.w,
      ),
      child: HomeCourseResumeCard(
        title: title,
        progress: progress,
        buttonText: buttonText,
        onPressed: continueCourse,
        image: image,
      ),
    );
  }
}
