import 'package:edulab_b2b/widget_imports.dart';

class HomeNoAssignedCoursesWidget extends StatelessWidget {
  final VoidCallback onTap;

  const HomeNoAssignedCoursesWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(10.w, 36.h, 10.w, 24.h),
      decoration: BoxDecoration(
        color: context.colors.bgSurface1,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Assets.icons.homeTabIcons.noAssignedCourses.image(
            width: 72.w,
            height: 72.w,
          ),
          space24,
          Column(
            children: [
              Text(
                context.localizations.noAssignedCoursesTitle,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  color: context.colors.fgDefault,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                context.localizations.noAssignedCoursesSubtitle,
                textAlign: TextAlign.center,
                maxLines: 3,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: context.colors.fgSoft,
                ),
              ),
            ],
          ),
          space16,
          GestureDetector(
            onTap: onTap,
            behavior: HitTestBehavior.opaque,
            child: Container(
              height: 48.h,
              width: 134.h,
              constraints: BoxConstraints(minWidth: 56.w),
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              decoration: BoxDecoration(
                color: context.colors.neutralContainerDefault.withOpacity(0.1),
                borderRadius: BorderRadius.circular(999.r),
              ),
              child: Center(
                child: AppText.headline1(
                  context.localizations.viewCourses,
                  color: context.colors.neutralOnContainer,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
