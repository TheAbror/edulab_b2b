import 'package:leti_mobile/widget_imports.dart';

class SignInPageStepOne extends StatelessWidget {
  const SignInPageStepOne({super.key});

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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.blocProgress == BlocProgress.IS_SUCCESS) {
            Navigator.pushNamed(context, AppRoutes.signInPageStepTwo);

            context.read<AuthBloc>().setInitialValue();
            context.read<AuthBloc>().setPhoneNumber(
              _phoneNumberController.text.trim(),
            );
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
                  controller: _phoneNumberController,
                  focusNode: _phoneFocusNode,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    UzbekistanPhoneFormatter(),
                    LengthLimitingTextInputFormatter(13),
                  ],
                  decoration: authFieldDecoration(
                    context,
                    '+998',
                  ),
                ),
                space16,
                ActionButton(
                  text: context.localizations.signin,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      _phoneFocusNode.unfocus();
                      context.read<AuthBloc>().signInStepOne(
                        _phoneNumberController.text.trim(),
                      );
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

class UzbekistanPhoneFormatter extends TextInputFormatter {
  static const prefix = '+998';
  static const prefixDigits = '998';

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // 1️⃣ Allow empty → show hint
    if (newValue.text.isEmpty) {
      return newValue;
    }

    if (newValue.text == prefix) {
      return const TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );
    }

    String digits = newValue.text.replaceAll(RegExp(r'\D'), '');

    if (digits.startsWith(prefixDigits)) {
      digits = digits.substring(prefixDigits.length);
    }

    final text = '$prefix$digits';

    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
