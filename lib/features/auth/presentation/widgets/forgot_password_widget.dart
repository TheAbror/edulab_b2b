import 'package:edulab_b2b/widget_imports.dart';

class ForgotPasswordWidget extends StatelessWidget {
  final VoidCallback onTap;

  const ForgotPasswordWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Text(
        '${context.localizations.forgotpassword}?',
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
    );
  }
}
