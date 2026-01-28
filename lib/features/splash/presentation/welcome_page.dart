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
            Expanded(
              child: Center(
                child: Assets.icons.letiLogoPng.image(
                  height: 96.h,
                  width: 171.w,
                ),
              ),
            ),
            SizedBox(height: 83.h),
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
                  context.localizations.trackYourLearning,
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
              text: context.localizations.joinForFree,
              onTap: () => Navigator.pushNamed(
                context,
                AppRoutes.loginPage,
              ),
            ),

            SizedBox(height: 12.h),
            ActionButton(
              text: context.localizations.login,
              onTap: () => Navigator.pushNamed(
                context,
                AppRoutes.loginPage,
              ),
              isFilled: false,
            ),

            SizedBox(height: 28.h),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.rootPage,
                  (route) => false,
                );
              },
              child: Center(
                child: Text(
                  context.localizations.skipfornow,
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: context.colors.neutralDefault,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            SizedBox(height: 70.h),
          ],
        ),
      ),
    );
  }
}
