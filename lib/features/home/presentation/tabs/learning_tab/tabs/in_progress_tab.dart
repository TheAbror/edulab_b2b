import 'package:edulab_b2b/widget_imports.dart';

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
                id: item[index].id,
                title: item[index].title,
                isFirst: index == 0 ? true : false,
                photo: item[index].thumbnail?.originalUrl ?? '',
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

          // Text(
          //   context.localizations.learningStatisctics,
          //   style: TextStyle(
          //     fontSize: 17.sp,
          //     fontWeight: FontWeight.w500,
          //     letterSpacing: -1,
          //   ),
          // ),
          // space8,
          //
          // LearningStreakCard(
          //   label: statistics.streak.label,
          //   streak: statistics.streak,
          // ),
          // space8,

          //
          // LearningStatisticsItem(
          //   headline: context.localizations.totalTimeLearning,
          //   statisticsData: statistics.totalTimeLearning,
          // ),
          // LearningStatisticsItem(
          //   headline: context.localizations.courseInProgress,
          //   statisticsData: statistics.inProgress,
          // ),
          // LearningStatisticsItem(
          //   headline: context.localizations.courseCompleted,
          //   statisticsData: statistics.completed,
          // ),
          // space24,
        ],
      ),
    );
  }
}
