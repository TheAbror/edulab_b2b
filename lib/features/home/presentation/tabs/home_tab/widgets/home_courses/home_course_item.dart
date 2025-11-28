import 'package:leti_mobile/widget_imports.dart';

class HomeCourseItem extends StatelessWidget {
  final String text;
  final String count;
  final VoidCallback onTap;

  const HomeCourseItem({
    super.key,
    required this.text,
    required this.count,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        margin: EdgeInsets.only(bottom: 10.h),
        decoration: BoxDecoration(
          color: context.colors.accentContainerSoft.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 15.sp,
                letterSpacing: -1,
                fontWeight: FontWeight.w500,
              ),
            ),
            space20,
            Text(
              count,
              style: TextStyle(
                fontSize: 14.sp,
                color: context.colors.fgMuted,
                fontWeight: FontWeight.w400,
                letterSpacing: -1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
