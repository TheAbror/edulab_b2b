import 'package:leti_mobile/widget_imports.dart';

class LearningStreakCard extends StatelessWidget {
  final String label;
  final StreakResponse streak;

  const LearningStreakCard({
    super.key,
    required this.label,
    required this.streak,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: context.colors.bgSurface4,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 42.h,
            child: ListView.separated(
              itemCount: 7,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final key = streak.days.toMap().keys.elementAt(index);
                final value = streak.days.toMap()[key];

                return StreakDayItems(
                  weekDay: key.makeFirstCapital().substring(0, 3),
                  isSuccess: value ?? false,
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(width: 26.w);
              },
            ),
          ),
          space16,
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 17.sp,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ),
    );
  }
}

class StreakDayItems extends StatelessWidget {
  final String weekDay;
  final bool isSuccess;

  const StreakDayItems({
    super.key,
    required this.weekDay,
    required this.isSuccess,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        isSuccess
            ? Container(
                height: 20.w,
                width: 20.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.r),
                  color: context.colors.successDefault,
                  border: Border.all(
                    color: context.colors.borderMuted.withOpacity(0.15),
                  ),
                ),
                child: Icon(Icons.done, size: 15, color: context.colors.float),
              )
            : Container(
                height: 20.w,
                width: 20.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.r),
                  border: Border.all(
                    color: context.colors.borderMuted.withOpacity(0.15),
                  ),
                ),
              ),
        SizedBox(height: 4.h),
        Text(
          weekDay,
          style: TextStyle(
            fontSize: 11.sp,
            fontWeight: FontWeight.w400,
            color: Theme.of(context).colorScheme.surfaceTint,
          ),
        ),
      ],
    );
  }
}
