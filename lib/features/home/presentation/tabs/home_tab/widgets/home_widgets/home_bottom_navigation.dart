import 'package:leti_mobile/widget_imports.dart';

class HomeBottomNavigation extends StatelessWidget {
  final int tabIndex;

  const HomeBottomNavigation({super.key, required this.tabIndex});

  @override
  Widget build(BuildContext context) {
    var navBar = Assets.icons.navbar;
    var lang = context.localizations;

    return Container(
      decoration: _Decoration(context),
      child: BottomNavigationBar(
        elevation: 0,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).colorScheme.background,
        showUnselectedLabels: true,
        selectedItemColor: context.colors.fgDefault,
        unselectedItemColor: context.colors.fgMuted,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w500, height: 1.5),
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w500,
          height: 1.5,
        ),
        currentIndex: tabIndex,
        onTap: (index) {
          context.read<HomeBloc>().changeTabIndex(index);
        },
        items: [
          BottomNavigationBarItem(
            label: lang.homeTab,

            icon: navBar.homeEmpty.svg(),
            // activeIcon: navBar.homeFilled.svg(),
            activeIcon: navBar.homeFilled.svg(
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.primary,
                BlendMode.srcIn,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: lang.learingTab,
            icon: navBar.learningEmpty.svg(),
            // activeIcon: navBar.learningFilled.svg(),
            activeIcon: navBar.learningFilled.svg(
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.primary,
                BlendMode.srcIn,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: lang.coursesTab,
            icon: navBar.coursesEmpty.svg(),
            activeIcon: navBar.coursesEmpty.svg(
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.primary,
                BlendMode.srcIn,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: lang.profileTab,
            icon: navBar.profileEmpty.svg(),
            activeIcon: navBar.profileEmpty.svg(
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.primary,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _Decoration(BuildContext context) {
    return BoxDecoration(
      border: Border(
        top: BorderSide(
          color: context.colors.borderMuted.withOpacity(0.15),
          width: 1.w,
        ),
      ),
    );
  }
}
