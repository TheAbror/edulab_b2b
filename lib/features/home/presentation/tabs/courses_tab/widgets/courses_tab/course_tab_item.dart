import 'package:edulab_b2b/widget_imports.dart';

class CourseTabItem extends StatelessWidget {
  final String text;
  final String count;
  final VoidCallback onTap;

  const CourseTabItem({
    super.key,
    required this.text,
    required this.count,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: context.colors.accentContainerSoft.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              text,
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
