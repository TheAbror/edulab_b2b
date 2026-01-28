import 'package:leti_mobile/widget_imports.dart';

class NoResultsWidget extends StatelessWidget {
  const NoResultsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 40.h),
        Assets.icons.courses.emptyState.svg(),
        SizedBox(height: 24.h),
        Text(
          context.localizations.noCoursesFound,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
        ),
        SizedBox(height: 8.h),
        Text(
          context.localizations.keepLearning,
          style: TextStyle(color: context.colors.fgMuted, fontSize: 15.sp),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.allCoursesPage);
          },
          child: Container(
            width: 180.w,
            height: 50.h,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Center(
              child: Text(
                context.localizations.browseCourses,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: context.colors.accentOnAccent,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
