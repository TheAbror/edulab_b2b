import 'package:edulab_b2b/widget_imports.dart';

class HomeTabAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeTabAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Assets.icons.main.edulabLogoSmall.svg(
                height: 26.w,
                width: 95.w,
              ),
              // Assets.icons.main.notification.svg(
              //   colorFilter: ColorFilter.mode(
              //     context.colors.neutralContainerActive,
              //     BlendMode.srcIn,
              //   ),
              // ),
            ],
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
