import 'package:edulab_b2b/widget_imports.dart';

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
        height: 48.w,
        width: 48.w,
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(defaultRadius.r)),
          border: Border.all(
            color: context.colors.borderMuted.withOpacity(0.15),
            width: 2.w,
          ),
        ),
        child: Assets.icons.learning.left.svg(
          colorFilter: ColorFilter.mode(
            context.colors.neutralDefault,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}

class LearningBottomNavButtonRight extends StatelessWidget {
  final VoidCallback onTap;
  final String text;

  const LearningBottomNavButtonRight({
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
        height: 48.w,
        width: 48.w,
        padding: EdgeInsets.all(12.w),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(defaultRadius.r)),
          border: Border.all(
            color: context.colors.borderMuted.withOpacity(0.15),
            width: 2.w,
          ),
        ),
        child: Assets.icons.learning.right.svg(
          colorFilter: ColorFilter.mode(
            context.colors.neutralDefault,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
