import 'package:edulab_b2b/widget_imports.dart';

/// "You're enrolled." callout shown at the top of the "About course" tab once
/// the learner is enrolled in the course.
class YoureEnrolledCard extends StatelessWidget {
  const YoureEnrolledCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: context.colors.bgSurface1,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Assets.icons.homeTabIcons.confetii.image(width: 48.w, height: 48.w),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.localizations.youreEnrolledTitle,
                    style: TextStyle(
                      fontSize: 17.sp,
                      height: 22 / 17,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.17,
                      color: context.colors.fgDefault,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Opacity(
                    opacity: 0.5,
                    child: Text(
                      context.localizations.youreEnrolledSubtitle,
                      style: TextStyle(
                        fontSize: 13.sp,
                        height: 16 / 13,
                        color: context.colors.fgDefault,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
