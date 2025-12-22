import 'package:leti_mobile/widget_imports.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SignUpPageAppBar(),
      body: _Body(),
      resizeToAvoidBottomInset: false,
    );
  }
}

class _Body extends StatefulWidget {
  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  final _formKey = GlobalKey<FormState>();
  final _login = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state.emailOrPhone.isNotEmpty && !state.isReponseSuccess) {
        } else if (state.blocProgress == BlocProgress.FAILED) {
          showMessage(state.failureMessage, context, isError: true);
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                space32,
                Text(
                  context.localizations.createayourccount,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                space10,
                Text(
                  context.localizations.buildskillsfortodayetc,
                  style: TextStyle(fontWeight: FontWeight.w400),
                ),
                space40,
                _loginField(context),
                space24,
                ActionButton(
                  text: context.localizations.signup,
                  onTap: () {
                    final login = _login.text.trim();

                    if (_formKey.currentState!.validate()) {
                      // context.read<AuthBloc>().sendSignUpKeyForVerification(sign_up_key);

                      context.read<AuthBloc>().saveLogin(login);
                      // Navigator.pushNamed(context,AppRoutes.codeVerificationPage, extra: false);

                      Navigator.pushNamed(context, AppRoutes.rootPage);
                    }
                  },
                ),
                // DividerWithOrText(),
                // ContinueWithGoogleButton(),
                Spacer(),
                Text(
                  context.localizations.bysignningAgree,
                  style: TextStyle(fontSize: 13.sp),
                ),
                space40,
              ],
            ),
          ),
        );
      },
    );
  }

  TextFormField _loginField(BuildContext context) {
    return TextFormField(
      validator: (username) {
        if (username == null || username.isEmpty) {
          return context.localizations.cantbeempty;
        }

        if (RegExp(r'^\d').hasMatch(username)) {
          if (!username.startsWith('998')) {
            return context.localizations.numberShouldStart;
          }
        } else {
          if (!emailRegEx.hasMatch(username)) {
            return context.localizations.pleaseEnterValidEmail;
          }
        }

        return null;
      },
      controller: _login,
      textInputAction: TextInputAction.next,
      decoration: authFieldDecoration(context, 'Phone number'),
    );
  }
}
