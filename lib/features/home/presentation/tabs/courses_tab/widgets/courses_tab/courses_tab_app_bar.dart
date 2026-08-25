import 'package:edulab_b2b/widget_imports.dart';

class CoursesTabAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CoursesTabAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: false,
      backgroundColor: context.colors.bgPage3,
      elevation: 0,
      scrolledUnderElevation: 0,
      title: AppText.title3(
        context.localizations.coursesTab.makeFirstCapital(),
        color: context.colors.fgDefault,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
