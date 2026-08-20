import 'package:edulab_b2b/widget_imports.dart';

class CompletedTab extends StatelessWidget {
  final List<CourseShortInfo> item;

  const CompletedTab({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: item.length,
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 24.h, bottom: 12.h),
      itemBuilder: (context, index) {
        final progress = item[index].progess;

        return LearningResumeCard(
          id: item[index].id,
          title: item[index].title,
          isFirst: false,
          photo: item[index].thumbnail?.originalUrl ?? '',
          progress: progress.toDouble(),
          buttonText: context.localizations.continueButton,
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.enrolledCoursePage);
          },
        );
      },
    );
  }
}
