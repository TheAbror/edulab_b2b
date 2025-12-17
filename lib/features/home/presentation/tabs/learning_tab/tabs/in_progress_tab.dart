import 'package:leti_mobile/widget_imports.dart';

class InProgressTab extends StatelessWidget {
  final List<CourseShortInfo> item;
  final LearningTabStatisticsResponse statistics;

  const InProgressTab({
    super.key,
    required this.item,
    required this.statistics,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.builder(
            itemCount: item.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(top: 24.h, bottom: 12.h),
            itemBuilder: (context, index) {
              final progress = item[index].progess;

              return LearningResumeCard(
                title: item[index].title,
                isFirst: index == 0 ? true : false,
                photo: item[index].thumbnail?.original_url ?? '',
                progress: progress.toDouble(),
                buttonText: context.localizations.continueButton,
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.learningPage,
                    arguments: OpenCourseByTopicSelectionModel(
                      courseID: item[index].id,
                    ),
                  );
                },
              );
            },
          ),

          Text(
            context.localizations.learningStatisctics,
            style: TextStyle(
              fontSize: 17.sp,
              fontWeight: FontWeight.w500,
              letterSpacing: -1,
            ),
          ),
          space16,
          //
          LearningStreakCard(
            label: statistics.streak.label,
            streak: statistics.streak,
          ),
          space8,

          //
          LearningStatisticsItem(
            headline: 'Total time learning',
            statisticsData: statistics.totalTimeLearning,
          ),
          LearningStatisticsItem(
            headline: 'Courses in progress',
            statisticsData: statistics.inProgress,
          ),
          LearningStatisticsItem(
            headline: 'Courses completed',
            statisticsData: statistics.completed,
          ),
          space24,
        ],
      ),
    );
  }
}
