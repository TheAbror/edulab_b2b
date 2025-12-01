import 'package:leti_mobile/widget_imports.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(), body: _Body());
  }
}

class _Body extends StatefulWidget {
  @override
  State<_Body> createState() => __BodyState();
}

class __BodyState extends State<_Body> {
  final TextEditingController _emailController = TextEditingController(
    text: 'qwerty@gmail.com',
  );

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.blocProgress == BlocProgress.IS_SUCCESS &&
            state.isReponseSuccess) {
          context.pushNamed(AppRoutes.signInPageStepTwo, extra: true);
          context.read<AuthBloc>().setInitialValue();
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
                context.localizations.enteryouremailorphone,
                style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w500),
              ),
              space10,
              Text(
                context.localizations.wellsendyou,
                style: TextStyle(fontWeight: FontWeight.w400),
              ),
              space40,
              TextFormField(
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
                controller: _emailController,
                textInputAction: TextInputAction.next,
                decoration: authFieldDecoration(
                  context,
                  'Email or Phone number',
                ),
              ),
              space24,
              ActionButton(
                text: context.localizations.signin,
                onTap: () {
                  context.read<AuthBloc>().getVerificationCodeBySendingLogin(
                    _emailController.text,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
