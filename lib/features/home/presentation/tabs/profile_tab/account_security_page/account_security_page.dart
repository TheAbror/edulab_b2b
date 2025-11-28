import 'package:leti_mobile/widget_imports.dart';

class AccountSecurityPage extends StatelessWidget {
  const AccountSecurityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileTabPagesAppBar(context, 'Account security'),
      body: Padding(
        padding: EdgeInsets.all(16.h),
        child: Column(
          children: [
            ProfileTabSubHeaderWithVerticalSpace(
              context,
              context.localizations.changepassword,
              () {},
            ),
            space32,
            ProfileTabSubHeaderWithVerticalSpace(
              context,
              context.localizations.priacySettings,
              () {
                Navigator.pushNamed(context, AppRoutes.privacySettingsPage);
              },
            ),
          ],
        ),
      ),
    );
  }
}
