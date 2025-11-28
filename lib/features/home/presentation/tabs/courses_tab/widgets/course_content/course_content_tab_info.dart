import 'package:leti_mobile/widget_imports.dart';

class CourseContentTabInfo extends StatelessWidget {
  const CourseContentTabInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        CourseContentConfettiCard(
          title: 'You\'re enrolled.',
          subTitle: 'You are enrolled, to begin click the "Start" button',
        ),
        CourseContentCertificated(
          headline: 'Congratulations on getting your certificate!',
          shareText: 'Share certificate',
          result: 'Result: 100%',
          subTitle: 'You completed this course on August 2, 2025',
          onTap: () {},
        ),
        SingleCourseBody(isContent: true),
      ],
    );
  }
}
