import 'package:leti_mobile/widget_imports.dart';

class LearningStatisticsItem extends StatelessWidget {
  final String headline;
  final String statisticsData;

  const LearningStatisticsItem({
    super.key,
    required this.headline,
    required this.statisticsData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      margin: EdgeInsets.only(bottom: 8.h),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          width: 1.w,
          color: context.colors.borderMuted.withOpacity(0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            headline.toUpperCase(),
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              letterSpacing: -0.8,
              color: context.colors.fgSoft,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            statisticsData,
            style: TextStyle(
              fontSize: 17.sp,
              fontWeight: FontWeight.w500,
              letterSpacing: -1,
            ),
          ),
        ],
      ),
    );
  }
}
