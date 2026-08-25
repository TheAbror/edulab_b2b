import 'package:edulab_b2b/widget_imports.dart';

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
        selectedFontSize: 13,
        unselectedFontSize: 13,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).colorScheme.background,
        showUnselectedLabels: true,
        selectedItemColor: context.colors.fgDefault,
        unselectedItemColor: context.colors.fgMuted,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600, height: 1.2),
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w400,
          height: 1.2,
        ),
        currentIndex: tabIndex,
        onTap: (index) {
          context.read<HomeBloc>().changeTabIndex(index);
        },
        items: [
          BottomNavigationBarItem(
            label: lang.homeTab,
            icon: navBar.homeFilled.svg(
              colorFilter: ColorFilter.mode(
                context.colors.fgMuted,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: navBar.homeFilled.svg(
              colorFilter: ColorFilter.mode(
                context.colors.fgDefault,
                BlendMode.srcIn,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: lang.coursesTab,
            icon: navBar.coursesEmpty.svg(
              colorFilter: ColorFilter.mode(
                context.colors.fgMuted,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: navBar.coursesEmpty.svg(
              colorFilter: ColorFilter.mode(
                context.colors.fgDefault,
                BlendMode.srcIn,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: lang.profileTab,
            icon: navBar.profileEmpty.svg(
              colorFilter: ColorFilter.mode(
                context.colors.fgMuted,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: navBar.profileEmpty.svg(
              colorFilter: ColorFilter.mode(
                context.colors.fgDefault,
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
