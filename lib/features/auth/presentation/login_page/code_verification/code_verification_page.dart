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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                space32,
                Text(
                  context.localizations.enterCode,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                space10,

                Text(
                  context.localizations.smsToNumber(state.phoneNumber),
                  style: TextStyle(fontWeight: FontWeight.w400),
                ),

                space40,
                OtpTextField(
                  autoFocus: true,
                  fieldWidth: 44.w,
                  contentPadding: EdgeInsets.all(11.w),
                  numberOfFields: 4,
                  borderColor: Theme.of(context).colorScheme.primary,
                  showFieldAsBox: true,
                  onCodeChanged: (String code) {},
                  onSubmit: (String code) {
                    FocusScope.of(context).unfocus();
                    context.read<AuthBloc>().signInStepTwo(code);
                  },
                ),
                space32,
                state.isCountDownFinished
                    ? GestureDetector(
                        onTap: () {
                          if (state.isCountDownFinished) {
                            context.read<AuthBloc>().setInitialValue();
                            context.read<AuthBloc>().signInStepOne(
                              state.phoneNumber,
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
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(context.localizations.resetafter),
                          Text(' '),
                          Text(state.timerSeconds.toString()),
                          Text(' ${context.localizations.seconds}'),
                        ],
                      ),
                space32,
              ],
            ),
          );
        },
      ),
    );
  }
}
