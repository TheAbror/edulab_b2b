import 'package:leti_mobile/widget_imports.dart';

class SignUpEnterDetailsPage extends StatelessWidget {
  const SignUpEnterDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: SignUpEnterDetailsPageAppBar(), body: _Body());
  }
}

class _Body extends StatefulWidget {
  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  late final TextEditingController _login;

  @override
  void initState() {
    super.initState();

    final state = context.read<AuthBloc>().state;

    _login = TextEditingController(text: state.emailOrPhone);
  }

  final _formKey = GlobalKey<FormState>();
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.blocProgress == BlocProgress.IS_SUCCESS &&
            state.isReponseSuccess) {
          Navigator.pushReplacementNamed(context, AppRoutes.rootPage);

          // Navigator.pushNamedAndRemoveUntil(context, AppRoutes.rootPage, (route) => false);
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
                  context.localizations.tellUsAboutYrself,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                space32,
                Text(
                  context.localizations.firstname,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                space8,
                _firstNameField(context),
                space16,
                Text(
                  context.localizations.lastname,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                space8,
                _lastNameField(context),
                space16,
                Text(
                  context.localizations.emailaddress,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                space8,
                _loginField(state, context),
                space16,
                Text(
                  context.localizations.password,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                space8,
                _passwordField(context),
                space40,
                ActionButton(
                  text: context.localizations.startlearning,
                  onTap: () {
                    final firstName = _firstName.text.trim();
                    final lastName = _lastName.text.trim();
                    final login = _login.text;
                    final password = _password.text.trim();

                    if (_formKey.currentState!.validate()) {
                      context.read<AuthBloc>().signUp(
                        firstName,
                        lastName,
                        login,
                        password,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  TextFormField _firstNameField(BuildContext context) {
    return TextFormField(
      validator: (username) {
        if (username == null || username.isEmpty) {
          return 'Cannot be empty';
        }

        return null;
      },
      controller: _firstName,
      textInputAction: TextInputAction.next,
      decoration: authFieldDecoration(context, ''),
    );
  }

  TextFormField _lastNameField(BuildContext context) {
    return TextFormField(
      validator: (username) {
        if (username == null || username.isEmpty) {
          return 'Can not be empty';
        }

        return null;
      },
      controller: _lastName,
      textInputAction: TextInputAction.next,
      decoration: authFieldDecoration(context, ''),
    );
  }

  TextFormField _loginField(AuthState state, BuildContext context) {
    return TextFormField(
      validator: (username) {
        if (username == null || username.isEmpty) {
          return 'Can not be empty';
        }
        if (username.length < 5) {
          return 'At least 5 characters required';
        }

        if (RegExp(r'^\d').hasMatch(username)) {
          if (!username.startsWith('998')) {
            return 'Number should start with 998';
          }
        } else {
          if (!emailRegEx.hasMatch(username)) {
            return 'Please enter a valid email';
          }
        }
        return null;
      },
      controller: _login,
      textInputAction: TextInputAction.next,
      decoration: authFieldDecoration(context, ''),
    );
  }

  TextFormField _passwordField(BuildContext context) {
    return TextFormField(
      validator: (username) {
        if (username == null || username.isEmpty) {
          return 'Can not be empty';
        }
        if (username.length < 5) {
          return 'At least 5 characters required';
        }
        return null;
      },
      controller: _password,
      textInputAction: TextInputAction.next,
      decoration: authFieldDecoration(
        context,
        '',
        // suffixicon: true,
      ),
    );
  }
}
