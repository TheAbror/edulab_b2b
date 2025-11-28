import 'package:leti_mobile/widget_imports.dart';

class SignInPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SignInPageAppBar({super.key});

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
            context.localizations.donthaveanaccountyet,
            style: TextStyle(
              fontSize: 15.sp,
              color: Theme.of(context).colorScheme.surfaceTint,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(width: 8.w),
          GestureDetector(
            onTap: () =>
                Navigator.pushReplacementNamed(context, AppRoutes.signUpPage),
            behavior: HitTestBehavior.opaque,
            child: SizedBox(
              width: 60.w,
              child: Text(
                context.localizations.signup,
                style: TextStyle(
                  fontSize: 15.sp,
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
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
