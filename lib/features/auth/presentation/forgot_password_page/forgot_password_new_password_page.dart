import 'package:leti_mobile/widget_imports.dart';

class ForgotPasswordNewPasswordPage extends StatelessWidget {
  const ForgotPasswordNewPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.blocProgress == BlocProgress.IS_SUCCESS) {
          Navigator.pushNamed(context, AppRoutes.forgotPasswordResetPage);

          context.read<AuthBloc>().setInitialValue();
        }
      },
      builder: (context, state) {
        return Scaffold(appBar: CustomAppBar(), body: _Body());
      },
    );
  }
}

class _Body extends StatefulWidget {
  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            space32,
            Text(
              context.localizations.newpassword,
              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w500),
            ),
            space40,
            Text(
              context.localizations.password,
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
            ),
            space8,
            TextFormField(
              validator: (username) {
                if (username == null || username.isEmpty) {
                  return 'Can not be empty';
                }
                if (controller1.text != controller2.text) {
                  return 'Passwords do not match';
                }
                return null;
              },
              controller: controller1,
              textInputAction: TextInputAction.next,
              decoration: authFieldDecoration(context, '', suffixicon: true),
            ),
            space16,
            Text(
              context.localizations.repeatpassword,
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
            ),
            space8,
            TextFormField(
              validator: (username) {
                if (username == null || username.isEmpty) {
                  return 'Can not be empty';
                }
                if (controller1.text != controller2.text) {
                  return 'Passwords do not match';
                }
                return null;
              },
              controller: controller2,
              textInputAction: TextInputAction.next,
              decoration: authFieldDecoration(context, '', suffixicon: true),
            ),
            space40,
            ActionButton(
              text: context.localizations.changepassword,
              onTap: () {
                context.read<AuthBloc>().resetPasswordToNew(
                  controller1.text.trim(),
                );
                // }
              },
            ),
          ],
        ),
      ),
    );
  }
}
