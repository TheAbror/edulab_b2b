import 'package:leti_mobile/widget_imports.dart';

class FavoritesTab extends StatelessWidget {
  final List<CourseShortInfo> item;

  const FavoritesTab({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: item.length,
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 24.h, bottom: 12.h),
      itemBuilder: (context, index) {
        // final progress = item[index].overallProgress;
        const progress = 0;

        return LearningResumeCard(
          title: item[index].title,
          isFirst: false,
          photo: item[index].thumbnail?.original_url ?? '',
          progress: progress.toDouble(),
          buttonText: context.localizations.continueButton,
          onPressed: () {
            Navigator.pushNamed(
              context,
              AppRoutes.mainCoursePage,
              arguments: item[index].id,
            );
          },
        );
      },
    );
  }
}
