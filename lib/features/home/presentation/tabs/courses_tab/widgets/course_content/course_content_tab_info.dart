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
          // CourseContentConfettiCard(
          //   title: 'You\'re enrolled.',
          //   subTitle: 'You are enrolled, to begin click the "Start" button',
          // ),
          // CourseContentCertificated(
          //   headline: 'Congratulations on getting your certificate!',
          //   shareText: 'Share certificate',
          //   result: 'Result: 100%',
          //   subTitle: 'You completed this course on August 2, 2025',
          //   onTap: () {},
          // ),
          SingleCourseBody(
            isContent: true,
            id: id,
          ),
        ],
      ),
    );
  }
}
