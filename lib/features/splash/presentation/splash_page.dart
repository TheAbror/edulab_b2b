import 'package:leti_mobile/widget_imports.dart';

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
      context.read<SplashBloc>().setupInitialSettings();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state.authStatus == SplashAuthStatus.authorized) {
          Navigator.pushReplacementNamed(context, AppRoutes.rootPage);
        } else {
          Navigator.pushReplacementNamed(
            context,
            AppRoutes.languageSelectionPage,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: _SplashView(),
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
        SizedBox(height: 260.h),
        Center(
          child: Assets.icons.main.letiLogo4x.image(
            width: 146.w,
            height: 116.w,
          ),
        ),
        SizedBox(height: 288.h),
        Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
    );
  }
}
