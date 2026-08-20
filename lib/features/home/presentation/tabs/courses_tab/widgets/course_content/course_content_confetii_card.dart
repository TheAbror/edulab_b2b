import 'package:edulab_b2b/widget_imports.dart';

class CourseContentConfettiCard extends StatelessWidget {
  final String title;
  final String subTitle;

  const CourseContentConfettiCard({
    super.key,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 16.h,
        right: 16.h,
        top: 16.h,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0XFF2E0661),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: -15,
            left: -25,
            child: Assets.icons.homeTabIcons.confettiBottom.image(),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            child: Center(
              child: Column(
                children: [
                  Assets.icons.homeTabIcons.confetii.image(
                    height: 48.w,
                    width: 48.w,
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: context.colors.float,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  SizedBox(
                    width: 288.w,
                    child: Text(
                      subTitle,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: context.colors.float,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  space8,
                ],
              ),
            ),
          ),
          Positioned(
            top: -15,
            right: -25,
            child: Assets.icons.homeTabIcons.confettiBottom.image(),
          ),
        ],
      ),
    );
  }
}
