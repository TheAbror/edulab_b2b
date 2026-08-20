import 'package:edulab_b2b/widget_imports.dart';

class LearningTabAppBar extends StatelessWidget implements PreferredSizeWidget {
  const LearningTabAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 90.h,
      automaticallyImplyLeading: false,
      title: Text(
        context.localizations.myLearning,
        style: TextStyle(
          color: context.colors.fgDefault,
          fontWeight: FontWeight.w500,
          fontSize: 17.sp,
        ),
      ),
      centerTitle: true,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(0.h),
        child: TabBar(
          tabAlignment: TabAlignment.start,
          unselectedLabelColor: context.colors.fgMuted,
          labelColor: Theme.of(context).colorScheme.primary,
          indicatorColor: Theme.of(context).colorScheme.primary,
          isScrollable: true,
          dividerColor: context.colors.borderMuted.withOpacity(0.15),
          tabs: [
            _Tab(context.localizations.inProgress),
            _Tab(context.localizations.completed),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(90);
}

Container _Tab(String text) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 10.h),
    child: Text(
      text,
      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
    ),
  );
}
