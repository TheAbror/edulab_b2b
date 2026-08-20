import 'package:edulab_b2b/widget_imports.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function? func;

  const CustomAppBar({super.key, this.func});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [CustomAppBarBackButton()],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class CustomAppBarBackButton extends StatelessWidget {
  final Function? func;

  const CustomAppBarBackButton({super.key, this.func});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (func != null) {
          func!();
        }
        Navigator.pop(context);
      },
      child: Icon(Icons.arrow_back),
      // Assets.icons.main.arrowBack.svg(
      //   colorFilter: ColorFilter.mode(
      //     Theme.of(context).colorScheme.secondaryContainer,
      //     BlendMode.srcIn,
      //   ),
      // ),
    );

    // IconButton(
    //   onPressed: () {
    //     if (func != null) {
    //       func!();
    //     }
    //     Navigator.pop(context);
    //   },
    //   padding: EdgeInsets.zero,
    //   constraints: BoxConstraints(),
    //   icon: Assets.icons.main.arrowBack.svg(
    //     colorFilter: ColorFilter.mode(
    //       Theme.of(context).colorScheme.secondaryContainer,
    //       BlendMode.srcIn,
    //     ),
    //   ),
    // );
  }
}
