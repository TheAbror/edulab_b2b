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
          'No courses found',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
        ),
        SizedBox(height: 8.h),
        Text(
          'Keep learning - your courses will appear here',
          style: TextStyle(color: context.colors.fgMuted, fontSize: 15.sp),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.allCoursesPage);
          },
          child: Container(
            width: 153.w,
            height: 48.h,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Center(
              child: Text(
                'Browse Courses',
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
