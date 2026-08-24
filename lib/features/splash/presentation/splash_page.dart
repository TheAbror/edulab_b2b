import 'package:edulab_b2b/features/splash/presentation/app_updates_view.dart';
import 'package:edulab_b2b/widget_imports.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SplashBloc>().getMinimumAppVersion();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashBloc, SplashState>(
      listenWhen: (previous, current) =>
          previous.authStatus != current.authStatus,
      listener: (context, state) {
        if (state.authStatus == SplashAuthStatus.authorized) {
          Navigator.pushReplacementNamed(context, AppRoutes.rootPage);
        } else if (state.authStatus == SplashAuthStatus.notAuthorized) {
          Navigator.pushReplacementNamed(
            context,
            AppRoutes.languageSelectionPage,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: state.showAppUpdatesPage ? AppUpdatesView() : _SplashView(),
        );
      },
    );
  }
}

class _SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Spacer(),
        Center(
          child: Assets.icons.main.edulabLogoBig.svg(
            width: 146.w,
            height: 116.w,
          ),
        ),
        Spacer(),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          child: Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        SizedBox(height: 34.h),
      ],
    );
  }
}
