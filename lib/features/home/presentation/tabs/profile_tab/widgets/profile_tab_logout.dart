import 'package:leti_mobile/widget_imports.dart';

class ProfileTabLogOutButton extends StatefulWidget {
  const ProfileTabLogOutButton({super.key});

  @override
  State<ProfileTabLogOutButton> createState() => _ProfileTabLogOutButtonState();
}

class _ProfileTabLogOutButtonState extends State<ProfileTabLogOutButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ApiProvider.create();
        // userBox.clear();
        // settingsBox.clear();

        context.read<AuthBloc>().clearAll();
        context.read<HomeBloc>().clearAll();
        context.read<CoursesBloc>().clearAll();
        context.read<LearningTabBloc>().clearAll();
        context.read<SplashBloc>().clearAll();
        context.read<ProfileBloc>().clearAll();
        context.read<LocalizationBloc>().clearAll();

        Navigator.pushNamed(context, AppRoutes.languageSelectionPage);
      },
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.icons.profile.logout.svg(
            colorFilter: ColorFilter.mode(
              Theme.of(context).colorScheme.primary,
              BlendMode.srcIn,
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            context.localizations.logout,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
