import 'package:leti_mobile/widget_imports.dart';

class LearningBottomNavButtonLeft extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final bool isEnabled;

  const LearningBottomNavButtonLeft({
    super.key,
    required this.onTap,
    required this.text,
    required this.isEnabled,
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
          border: Border.all(
            color: isEnabled
                ? context.colors.accentMuted
                : context.colors.borderMuted.withOpacity(0.15),
            width: 2.w,
          ),
        ),
        child: Row(
          children: [
            Spacer(),
            Assets.icons.learning.left.svg(
              colorFilter: ColorFilter.mode(
                isEnabled
                    ? Theme.of(context).colorScheme.primary
                    : context.colors.borderMuted.withOpacity(0.15),
                BlendMode.srcIn,
              ),
            ),
            SizedBox(width: 8.w),
            Text(
              text,
              style: TextStyle(
                fontSize: 15.sp,
                color: isEnabled
                    ? Theme.of(context).colorScheme.primary
                    : context.colors.borderMuted.withOpacity(0.15),
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
  final bool isEnabled;

  const LearningBottomNavButtonRight({
    super.key,
    required this.onTap,
    required this.text,
    required this.isEnabled,
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
          border: Border.all(
            color: isEnabled
                ? context.colors.accentMuted
                : context.colors.borderMuted.withOpacity(0.15),

            width: 2.w,
          ),
        ),
        child: Row(
          children: [
            Spacer(flex: 2),
            Text(
              text,
              style: TextStyle(
                fontSize: 15.sp,
                color: isEnabled
                    ? Theme.of(context).colorScheme.primary
                    : context.colors.borderMuted.withOpacity(0.15),
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 8.w),
            Assets.icons.learning.right.svg(
              colorFilter: ColorFilter.mode(
                isEnabled
                    ? Theme.of(context).colorScheme.primary
                    : context.colors.borderMuted.withOpacity(0.15),
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
