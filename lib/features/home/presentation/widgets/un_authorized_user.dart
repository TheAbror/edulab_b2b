import 'package:edulab_b2b/widget_imports.dart';

class UnAuthorizedUser extends StatelessWidget {
  const UnAuthorizedUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Assets.icons.main.edulabLogoBig.svg(
            height: 64.h,
            width: 81.w,
          ),
        ),

        SizedBox(height: 10.h),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              context.localizations.welcomeToLetiEdu,
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w500,
                letterSpacing: -1,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.h),

            Text(
              context.localizations.singInToAccess,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
                color: context.colors.fgMuted,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        SizedBox(height: 30.h),
        ActionButton(
          text: context.localizations.login,
          onTap: () {
            context.read<HomeBloc>().changeTabIndex(0);

            Navigator.pushNamed(
              context,
              AppRoutes.loginPage,
            );
          },
        ),
      ],
    );
  }
}
