import 'package:leti_mobile/widget_imports.dart';

Future<dynamic> LearningStreakPopUp(
  BuildContext context,
  List<String> weekDaysList,
  List<bool> weekDaysListisSuccess,
) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 328.w,
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Assets.icons.learning.fire.image(width: 64.w, height: 77.h),
                space24,
                SizedBox(
                  height: 44.h,
                  width: 244.w,
                  child: Center(
                    child: ListView.separated(
                      itemCount: 7,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return StreakDayItems(
                          weekDay: weekDaysList[index],
                          isSuccess: weekDaysListisSuccess[index],
                        );
                      },
                      separatorBuilder: (context, index) =>
                          SizedBox(width: 13.w),
                    ),
                  ),
                ),
                space24,
                Text(
                  'You’re on a 15-day streak! 🔥',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 24.sp,
                    letterSpacing: -1.2,
                  ),
                ),
                space8,
                Text(
                  'Just 1 more day and you’ll have been learning for 20 whole weeks, what a streak!20',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16.sp,
                    color: Theme.of(context).colorScheme.surfaceTint,
                  ),
                  textAlign: TextAlign.center,
                ),
                space24,
                ActionButton(
                  text: 'Okay, got it!',
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}
