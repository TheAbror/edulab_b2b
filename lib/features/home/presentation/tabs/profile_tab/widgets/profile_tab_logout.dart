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

          // Before clearAll, which drops the path this needs to find the
          // cached avatar. Not awaited (like clearAll below): the path is read
          // synchronously, so the deletion can finish after we've navigated.
          ProfilePhotoStorage.clear();
          PreferencesServices.clearAll();

          Navigator.pushReplacementNamed(
            context,
            AppRoutes.languageSelectionPage,
          );
        }
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 48.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: context.colors.bgSurface1,
          borderRadius: BorderRadius.circular(999.r),
        ),
        child: Text(
          context.localizations.logout,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            letterSpacing: -0.16,
            color: context.colors.neutralOnContainer,
          ),
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
