import 'dart:async';
import 'package:leti_mobile/widget_imports.dart';

class CodeVerificationPage extends StatefulWidget {
  final bool isForgorPassword;

  const CodeVerificationPage({super.key, required this.isForgorPassword});

  @override
  State<CodeVerificationPage> createState() => _CodeVerificationPageState();
}

class _CodeVerificationPageState extends State<CodeVerificationPage> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    startTimer(context);
  }

  void startTimer(BuildContext context) {
    final state = context.read<AuthBloc>().state;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (state.timerSeconds > 0) {
        context.read<AuthBloc>().decrementTimerSeconds();
      } else {
        _timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
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
          if (state.isVerificationSuccess) {
            Timer(Duration(seconds: 1), () {
              if (!mounted) return;
              context.read<AuthBloc>().setInitialValue();

              widget.isForgorPassword
                  ? Navigator.pushReplacementNamed(
                      context,
                      AppRoutes.forgotPasswordSetNewPassword,
                    )
                  : Navigator.pushReplacementNamed(
                      context,
                      AppRoutes.singUpEnterDetailsPage,
                    );
            });
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
                  context.localizations.entercode,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                space10,
                Row(
                  children: [
                    Text(
                      context.localizations.wehavesentyoucodeto,
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                    SizedBox(width: 4.h),
                    Text('+ 998991234567'),
                  ],
                ),
                space40,
                OtpTextField(
                  fieldWidth: 44.w,
                  contentPadding: EdgeInsets.all(11.w),
                  numberOfFields: 4,
                  borderColor: Theme.of(context).colorScheme.primary,
                  showFieldAsBox: true,
                  onCodeChanged: (String code) {},
                  onSubmit: (String verificationCode) {
                    context.read<AuthBloc>().verificationSuccess(true);
                  }, // end onSubmit
                ),
                space32,
                state.isVerificationSuccess
                    ? Center(
                        child: Assets.icons.welcomeSignForgotIcons.successCircle
                            .svg(),
                      )
                    : state.isCountDownFinished
                    ? GestureDetector(
                        onTap: () {
                          if (state.isCountDownFinished) {
                            startTimer(context);
                            context.read<AuthBloc>().setInitialValue();
                          }
                        },
                        behavior: HitTestBehavior.opaque,
                        child: Center(
                          child: Text(
                            'Resend code',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(context.localizations.resetafter),
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
