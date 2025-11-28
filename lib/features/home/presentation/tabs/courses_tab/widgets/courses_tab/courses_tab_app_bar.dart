import 'package:leti_mobile/widget_imports.dart';

class CoursesTabAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CoursesTabAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(automaticallyImplyLeading: false, title: SearchAndFilter());
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
