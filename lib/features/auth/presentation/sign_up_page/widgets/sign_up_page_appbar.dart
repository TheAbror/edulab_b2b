import 'package:leti_mobile/widget_imports.dart';

class SignUpPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SignUpPageAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomAppBarBackButton(),
          Spacer(),
          Text(
            context.localizations.existinguser,
            style: TextStyle(
              fontSize: 15.sp,
              color: Theme.of(context).colorScheme.surfaceTint,
              fontWeight: FontWeight.w400,
              letterSpacing: -1,
            ),
          ),
          SizedBox(width: 8.w),
          GestureDetector(
            onTap: () =>
                Navigator.pushReplacementNamed(context, AppRoutes.signInPage),
            behavior: HitTestBehavior.opaque,
            child: Text(
              context.localizations.signin,
              style: TextStyle(
                fontSize: 15.sp,
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w500,
                letterSpacing: -1,
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
