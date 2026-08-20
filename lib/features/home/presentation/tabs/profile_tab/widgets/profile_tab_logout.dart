import 'package:edulab_b2b/widget_imports.dart';

class ProfileTabLogOutButton extends StatefulWidget {
  const ProfileTabLogOutButton({super.key});

  @override
  State<ProfileTabLogOutButton> createState() => _ProfileTabLogOutButtonState();
}

class _ProfileTabLogOutButtonState extends State<ProfileTabLogOutButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final result = await showConfirmDialog(context);

        if (result != null && result) {
          if (!context.mounted) return;

          context.read<AuthBloc>().clearAll();
          context.read<HomeBloc>().clearAll();
          context.read<CoursesBloc>().clearAll();
          context.read<LearningTabBloc>().clearAll();
          context.read<SplashBloc>().clearAll();
          context.read<ProfileBloc>().clearAll();
          context.read<LocalizationBloc>().clearAll();
          ApiProvider.create();
          PreferencesServices.clearAll();

          Navigator.pushReplacementNamed(
            context,
            AppRoutes.languageSelectionPage,
          );
        }
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h),
        decoration: BoxDecoration(
          color: context.colors.neutralContainerDefault.withOpacity(0.1),
          borderRadius: BorderRadius.circular(6.r),
        ),
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
      ),
    );
  }
}

Future<bool?> showConfirmDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      title: const Text('Are you sure?'),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Yes'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('No'),
        ),
      ],
    ),
  );
}
