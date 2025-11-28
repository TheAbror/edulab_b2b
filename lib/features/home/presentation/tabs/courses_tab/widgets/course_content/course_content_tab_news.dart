import 'package:leti_mobile/widget_imports.dart';

class CourseContentTabNews extends StatelessWidget {
  const CourseContentTabNews({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 53,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Text('News ${index + 1}');
      },
    );
  }
}
