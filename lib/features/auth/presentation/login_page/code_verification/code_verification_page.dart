import 'package:edulab_b2b/widget_imports.dart';

class CodeVerificationPage extends StatefulWidget {
  const CodeVerificationPage({super.key});

  @override
  State<CodeVerificationPage> createState() => _CodeVerificationPageState();
}

class _CodeVerificationPageState extends State<CodeVerificationPage> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      final currentState = context.read<AuthBloc>().state;
      if (currentState.timerSeconds >= 0) {
        context.read<AuthBloc>().decrementTimerSeconds();
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _maskIdentifier(AuthState state) {
    if (state.authMethod == AuthMethod.email) {
      final email = state.email;
      final atIndex = email.indexOf('@');
      if (atIndex <= 0) return email;
      final name = email.substring(0, atIndex);
      final domain = email.substring(atIndex + 1);
      final maskedName = name.length <= 2
          ? name
          : '${name.substring(0, 2)}${'*' * (name.length - 2)}';
      final maskedDomain = domain.length <= 3
          ? domain
          : '${'*' * (domain.length - 3)}${domain.substring(domain.length - 3)}';
      return '$maskedName@$maskedDomain';
    }

    final phone = state.phoneNumber;
    if (phone.length < 6) return phone;
    return '${phone.substring(0, phone.length - 4)}****';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.bgPage2,
      appBar: CustomAppBar(
        func: () {
          context.read<AuthBloc>().setInitialValue();
        },
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.blocProgress == BlocProgress.IS_SUCCESS) {
            if (state.authResponse.signUpRequired == true) {
              context.read<AuthBloc>().setInitialValue();

              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.enterDetailsPage,
                (route) => false,
              );
            } else {
              context.read<AuthBloc>().setInitialValue();

              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.rootPage,
                (route) => false,
              );
            }
          }
        },
        builder: (context, state) {
          final hasError = state.blocProgress == BlocProgress.FAILED;
          final errorColor = context.colors.errorDefault;

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
              decoration: BoxDecoration(
                color: context.colors.float,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    context.localizations.entercode,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w500,
                      color: context.colors.fgDefault,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    '${state.authMethod == AuthMethod.email ? context.localizations.codeSentViaEmail : context.localizations.codeSentViaSms}\n${_maskIdentifier(state)}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: context.colors.fgSoft,
                    ),
                  ),
                  SizedBox(height: 32.h),
                  OtpTextField(
                    autoFocus: true,
                    fieldWidth: 48.w,
                    contentPadding: EdgeInsets.all(11.w),
                    numberOfFields: 4,
                    borderRadius: BorderRadius.circular(6.r),
                    borderWidth: 1.w,
                    enabledBorderColor: hasError
                        ? errorColor
                        : context.colors.borderMuted,
                    focusedBorderColor: hasError
                        ? errorColor
                        : Theme.of(context).colorScheme.primary,
                    borderColor: hasError
                        ? errorColor
                        : context.colors.borderMuted,
                    textStyle: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w500,
                      color: hasError ? errorColor : context.colors.fgSoft,
                    ),
                    showFieldAsBox: true,
                    onCodeChanged: (String code) {
                      if (hasError) {
                        context.read<AuthBloc>().makeBlocProgressNotStarted();
                      }
                    },
                    onSubmit: (String code) {
                      FocusScope.of(context).unfocus();
                      context.read<AuthBloc>().signInStepTwo(code);
                    },
                  ),
                  SizedBox(height: 16.h),
                  if (hasError)
                    Text(
                      state.failureMessage,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15.sp, color: errorColor),
                    ),
                  SizedBox(height: 16.h),
                  state.isCountDownFinished
                      ? GestureDetector(
                          onTap: () {
                            if (state.isCountDownFinished) {
                              context.read<AuthBloc>().setInitialValue();
                              context.read<AuthBloc>().signInStepOne(
                                state.authMethod == AuthMethod.email
                                    ? state.email
                                    : state.phoneNumber,
                                true,
                              );
                              startTimer();
                            }
                          },
                          behavior: HitTestBehavior.opaque,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Assets.icons.resendCode.svg(),
                              SizedBox(width: 8.w),
                              Text(
                                context.localizations.resendCode,
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Center(
                          child: Text(
                            context.localizations.resetafter(
                              state.timerSeconds,
                            ),
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: context.colors.fgSoft,
                            ),
                          ),
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
