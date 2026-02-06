import 'package:leti_mobile/widget_imports.dart';

class CoursesTabAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CoursesTabAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    // return AppBar(automaticallyImplyLeading: false, title: SearchAndFilter());
    return AppBar(
      automaticallyImplyLeading: false,
      title: AppText.customTitle2Medium(
        context.localizations.coursesTab.makeFirstCapital(),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
