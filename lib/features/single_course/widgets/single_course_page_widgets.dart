import 'package:edulab_b2b/widget_imports.dart';

class CourseInfoAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int id;

  const CourseInfoAppBar({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      backgroundColor: context.colors.bgPage3,
      elevation: 0,
      scrolledUnderElevation: 0,
      title: Row(
        children: [
          SizedBox(width: 16.w),
          CustomAppBarBackButton(),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class CourseInfoShowAllButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool isPaddingNeeded;

  const CourseInfoShowAllButton({
    super.key,
    required this.onTap,
    this.isPaddingNeeded = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        margin: EdgeInsets.symmetric(horizontal: isPaddingNeeded ? 16.w : 0.w),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(defaultRadius.r)),
          border: Border.all(
            color: context.colors.borderMuted.withOpacity(0.15),
            width: 2.w,
          ),
        ),
        child: Center(
          child: Text(
            context.localizations.showAll,
            style: TextStyle(
              fontSize: 16.sp,
              color: context.colors.accentOnContainer,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
