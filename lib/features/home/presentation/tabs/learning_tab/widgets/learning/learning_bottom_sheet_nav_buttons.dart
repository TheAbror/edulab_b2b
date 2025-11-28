import 'package:leti_mobile/widget_imports.dart';

class LearningBottomNavButtonLeft extends StatelessWidget {
  final VoidCallback onTap;
  final String text;

  const LearningBottomNavButtonLeft({
    super.key,
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 36,
        width: 105,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(defaultRadius.r)),
          border: Border.all(color: context.colors.accentMuted, width: 2.w),
        ),
        child: Row(
          children: [
            Spacer(),
            Assets.icons.learning.left.svg(
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.primary,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(width: 8.w),
            Text(
              text,
              style: TextStyle(
                fontSize: 15.sp,
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}

class LearningBottomNavButtonRight extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  // final Widget widget;

  const LearningBottomNavButtonRight({
    super.key,
    required this.onTap,
    required this.text,
    // required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 36,
        width: 105,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(defaultRadius.r)),
          border: Border.all(color: context.colors.accentMuted, width: 2.w),
        ),
        child: Row(
          children: [
            Spacer(flex: 2),
            Text(
              text,
              style: TextStyle(
                fontSize: 15.sp,
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 8.w),
            Assets.icons.learning.right.svg(
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.primary,
                BlendMode.srcIn,
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
