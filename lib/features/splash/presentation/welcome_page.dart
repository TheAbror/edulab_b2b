import 'package:leti_mobile/widget_imports.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 66.h),
            CustomAppBarBackButton(),
            SizedBox(height: 42.h),
            Assets.icons.welcomeSignForgotIcons.handWithLightBulb3Png.image(),
            SizedBox(height: 83.h),
            Text(
              context.localizations.welcomeToLetiEdu,
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w500,
                letterSpacing: -1,
              ),
            ),
            SizedBox(height: 10.h),
            AppText.paragraph1(
              context.localizations.trackYourLearning,
              color: context.colors.fgMuted,
              maxLines: 3,
            ),
            SizedBox(height: 35.h),
            ActionButton(
              text: context.localizations.createAnAccount,
              onTap: () => Navigator.pushNamed(context, AppRoutes.signUpPage),
            ),
            SizedBox(height: 12.h),
            ActionButton(
              text: context.localizations.signin,
              onTap: () => Navigator.pushNamed(
                context,
                AppRoutes.signInPageStepOne,
              ),
              isFilled: false,
            ),
            // SizedBox(height: 28.h),
            // GestureDetector(
            //   behavior: HitTestBehavior.opaque,
            //   onTap: () {
            //     Navigator.pushNamedAndRemoveUntil(
            //       context,
            //       AppRoutes.rootPage,
            //       (route) => false,
            //     );
            //   },
            //   child: Center(
            //     child: Text(
            //       context.localizations.skipfornow,
            //       style: TextStyle(
            //         fontSize: 15.sp,
            //         color: context.colors.neutralDefault,
            //         fontWeight: FontWeight.w500,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
