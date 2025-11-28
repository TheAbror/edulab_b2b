import 'package:leti_mobile/widget_imports.dart';

class ForgotPasswordResetPage extends StatelessWidget {
  const ForgotPasswordResetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(), body: _Body());
  }
}

class _Body extends StatefulWidget {
  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          space32,
          Assets.icons.welcomeSignForgotIcons.passwordReset.image(
            height: 176.h,
            width: 228.w,
          ),
          space24,
          Text(
            context.localizations.passwordreset,
            style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w500),
          ),
          space32,
          ActionButton(
            text: context.localizations.signinnow,
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.rootPage);

              // if (formKey.currentState!.validate()) {
              // }
            },
          ),
        ],
      ),
    );
  }
}
