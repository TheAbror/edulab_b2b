import 'package:leti_mobile/widget_imports.dart';

class SignUpEnterDetailsPageAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const SignUpEnterDetailsPageAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // IconButton(
          //   onPressed: () {
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
          // ),
          CustomAppBarBackButton(
            func: () {
              context.read<AuthBloc>().setInitialValue();
            },
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, AppRoutes.rootPage);
            },
            behavior: HitTestBehavior.opaque,
            child: Text(
              context.localizations.skipstep,
              style: TextStyle(
                fontSize: 15.sp,
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
