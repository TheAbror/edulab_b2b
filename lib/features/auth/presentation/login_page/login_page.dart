import 'package:edulab_b2b/widget_imports.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: context.colors.bgPage2,
      appBar: LoginPageAppBar(),
      body: _Body(),
    );
  }
}

class _Body extends StatefulWidget {
  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  final _identifierController = TextEditingController();
  final _identifierFocusNode = FocusNode();

  static final _emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  @override
  void initState() {
    super.initState();
    _identifierFocusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    final authMethod = context.read<AuthBloc>().state.authMethod;
    if (authMethod == AuthMethod.phone &&
        _identifierFocusNode.hasFocus &&
        _identifierController.text.isEmpty) {
      _identifierController.text = '+998';
      _identifierController.selection = TextSelection.fromPosition(
        TextPosition(offset: _identifierController.text.length),
      );
    }
  }

  bool _isValid(String value, AuthMethod method) {
    if (method == AuthMethod.phone) return value.length == 13;
    return _emailRegex.hasMatch(value.trim());
  }

  void _onMethodChanged(AuthMethod method) {
    _identifierController.clear();
    context.read<AuthBloc>().setAuthMethod(method);
  }

  @override
  void dispose() {
    _identifierFocusNode.removeListener(_onFocusChange);
    _identifierFocusNode.dispose();
    _identifierController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.blocProgress == BlocProgress.IS_SUCCESS) {
            context.read<AuthBloc>().makeBlocProgressNotStarted();

            Navigator.pushNamed(
              context,
              AppRoutes.codeVerificationPage,
            );

            context.read<AuthBloc>().setInitialValue();
          }
        },
        builder: (context, state) {
          final hasError = state.blocProgress == BlocProgress.FAILED;

          return Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: 10.w,
              vertical: 20.h,
            ),
            decoration: BoxDecoration(
              color: context.colors.float,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  context.localizations.welcometoLeti,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24.sp,
                    letterSpacing: -0.8,
                    fontWeight: FontWeight.w500,
                    color: context.colors.fgDefault,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  context.localizations.continueLearningAndGrowing,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    letterSpacing: -0.5,
                    fontWeight: FontWeight.w500,
                    color: context.colors.fgSoft,
                  ),
                ),
                SizedBox(height: 24.h),
                AuthMethodSegmentControl(
                  value: state.authMethod,
                  onChanged: _onMethodChanged,
                ),
                SizedBox(height: 12.h),
                AuthIdentifierField(
                  method: state.authMethod,
                  controller: _identifierController,
                  focusNode: _identifierFocusNode,
                  hasError: hasError,
                  onChanged: (value) {
                    final isValid = _isValid(value, state.authMethod);
                    if (isValid != !state.isDisabled) {
                      if (isValid) {
                        context.read<AuthBloc>().enableButton();
                      } else {
                        context.read<AuthBloc>().disableButton();
                      }
                    }
                  },
                ),
                if (hasError) ...[
                  SizedBox(height: 12.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: context.colors.errorContainerDefault,
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Text(
                      state.failureMessage,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        color: context.colors.fgDefault,
                      ),
                    ),
                  ),
                ],
                SizedBox(height: 12.h),
                _ContinueButton(
                  isDisabled: state.isDisabled,
                  onTap: () {
                    final value = _identifierController.text.trim();
                    if (_isValid(value, state.authMethod) &&
                        !state.isDisabled) {
                      _identifierFocusNode.unfocus();
                      context.read<AuthBloc>().signInStepOne(value, false);
                    }
                  },
                ),
                SizedBox(height: 24.h),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: context.colors.fgDefault,
                    ),
                    children: [
                      TextSpan(
                        text: '${context.localizations.legalConsentPrefix} ',
                      ),
                      TextSpan(
                        text: context.localizations.termsAndPrivacyPolicy,
                        style: TextStyle(
                          color: context.colors.infoDefault,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ContinueButton extends StatelessWidget {
  final bool isDisabled;
  final VoidCallback onTap;

  const _ContinueButton({required this.isDisabled, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: onTap,
          behavior: HitTestBehavior.opaque,
          child: Container(
            height: 48.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isDisabled
                  ? context.colors.neutralContainerDefault.withOpacity(0.1)
                  : Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(999.r),
            ),
            child: state.blocProgress == BlocProgress.IS_LOADING
                ? SizedBox(
                    width: 18.w,
                    height: 18.w,
                    child: CircularProgressIndicator(
                      color: context.colors.float,
                      strokeWidth: 2.w,
                    ),
                  )
                : Text(
                    context.localizations.continueButton,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.16,
                      color: isDisabled
                          ? context.colors.fgDisabled.withOpacity(0.4)
                          : context.colors.float,
                    ),
                  ),
          ),
        );
      },
    );
  }
}
