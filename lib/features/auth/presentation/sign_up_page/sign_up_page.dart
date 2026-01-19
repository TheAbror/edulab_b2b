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
  final TextEditingController _phoneNumberController = TextEditingController();
  final FocusNode _phoneFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _phoneFocusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (_phoneFocusNode.hasFocus && _phoneNumberController.text.isEmpty) {
      // Set the prefix when field gains focus and is empty
      _phoneNumberController.text = '+998';
      _phoneNumberController.selection = TextSelection.fromPosition(
        TextPosition(offset: _phoneNumberController.text.length),
      );
    }
  }

  @override
  void dispose() {
    _phoneFocusNode.removeListener(_onFocusChange);
    _phoneFocusNode.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.blocProgress == BlocProgress.IS_SUCCESS) {
          Navigator.pushNamed(context, AppRoutes.codeVerificationPage);

          context.read<AuthBloc>().setInitialValue();
          context.read<AuthBloc>().setPhoneNumber(
            _phoneNumberController.text.trim(),
          );
        } else if (state.blocProgress == BlocProgress.FAILED) {
          showMessage(state.failureMessage, context, isError: true);
        }
      },
      builder: (context, state) {
        return Padding(
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
                  final login = _phoneNumberController.text.trim();

                  if (login.length == 13) {
                    context.read<AuthBloc>().saveLogin(login);
                    _phoneFocusNode.unfocus();
                    context.read<AuthBloc>().signInStepOne(
                      _phoneNumberController.text.trim(),
                    );
                  }
                },
              ),

              Spacer(),
              Text(
                context.localizations.bysignningAgree,
                style: TextStyle(fontSize: 13.sp),
              ),
              space40,
            ],
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
            return context.localizations.pleaseEnterValidPhoneNumber;
          }
        }

        return null;
      },
      controller: _phoneNumberController,
      inputFormatters: [
        UzbekistanPhoneFormatter(),
        LengthLimitingTextInputFormatter(13),
      ],
      textInputAction: TextInputAction.next,
      decoration: authFieldDecoration(context, '+998'),
    );
  }
}
