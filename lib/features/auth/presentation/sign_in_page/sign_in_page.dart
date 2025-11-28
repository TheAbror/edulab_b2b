// ignore_for_file: unused_local_variable

import 'package:leti_mobile/widget_imports.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: SignInPageAppBar(),
      body: _Body(),
    );
  }
}

class _Body extends StatefulWidget {
  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  final _formKey = GlobalKey<FormState>();
  final _username = TextEditingController(text: '');
  final _password = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.blocProgress == BlocProgress.IS_SUCCESS) {
            Navigator.pushNamed(context, AppRoutes.rootPage);

            // context.read<AuthBloc>().setInitialValue();
          } else if (state.blocProgress == BlocProgress.FAILED) {
            showMessage(state.failureMessage, context, isError: true);
          }
        },
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                space32,
                Text(
                  context.localizations.welcomeBack,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                space32,
                TextFormField(
                  controller: _username,
                  textInputAction: TextInputAction.next,
                  decoration: authFieldDecoration(
                    context,
                    'Email or Phone number',
                  ),
                ),
                space16,
                TextFormField(
                  controller: _password,
                  textInputAction: TextInputAction.next,
                  decoration: authFieldDecoration(
                    context,
                    'Password',
                    suffixicon: true,
                  ),
                ),
                SizedBox(height: 12.h),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     GestureDetector(
                //       behavior: HitTestBehavior.opaque,
                //       onTap: () {

                // Navigator.pushNamed(context, AppRoutes.forgotPasswordPage);

                //       },
                //       child: Text(
                //         context.localizations.forgotpassword,
                //         style: TextStyle(
                //           fontSize: 14.sp,
                //           color: Theme.of(context).colorScheme.primary,
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                space16,
                ActionButton(
                  text: context.localizations.signin,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      final username = _username.text.trim();
                      final password = _password.text.trim();

                      context.read<AuthBloc>().signIn(username, password);
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
