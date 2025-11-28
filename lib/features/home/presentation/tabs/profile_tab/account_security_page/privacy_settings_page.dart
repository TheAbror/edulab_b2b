import 'package:leti_mobile/widget_imports.dart';
import 'package:flutter/cupertino.dart';

class PrivacySettingsPage extends StatelessWidget {
  const PrivacySettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileTabPagesAppBar(context, 'Privacy settings'),
      body: BlocProvider(
        create: (context) => AccountSecurityBloc(),
        child: BlocBuilder<AccountSecurityBloc, AccountSecurityState>(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _privacySettingsItem(
                    context,
                    context.localizations.showYourProfileToLoggedUsers,
                    state.showProfileInfo,
                    (value) {
                      context.read<AccountSecurityBloc>().changeShowProfileInfo(
                        value,
                      );
                    },
                  ),
                  space32,
                  _privacySettingsItem(
                    context,
                    context.localizations.showCoursesYouAreTaking,
                    state.showCoursesInfo,
                    (value) {
                      context.read<AccountSecurityBloc>().changeShowCoursesInfo(
                        value,
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Padding _privacySettingsItem(
    BuildContext context,
    String text,
    bool isOn,
    Function(bool)? onChanged,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 260.w,
            child: Text(
              text,
              maxLines: 2,
              style: TextStyle(fontSize: 16.sp),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Platform.isAndroid
              ? Switch(
                  value: isOn,
                  activeColor: Theme.of(context).colorScheme.primary,
                  onChanged: onChanged,
                )
              : CupertinoSwitch(
                  value: isOn,
                  activeColor: Theme.of(context).colorScheme.primary,
                  onChanged: onChanged,
                ),
        ],
      ),
    );
  }
}
