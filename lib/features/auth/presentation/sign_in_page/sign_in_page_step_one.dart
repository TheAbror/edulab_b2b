// ignore_for_file: unused_local_variable

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
  final _phoneNumber = TextEditingController(text: '+998990004444');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.blocProgress == BlocProgress.IS_SUCCESS) {
            Navigator.pushNamed(
              context,
              AppRoutes.signInPageStepTwo,
            );

            context.read<AuthBloc>().setInitialValue();
            context.read<AuthBloc>().setPhoneNumber(_phoneNumber.text.trim());
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
                  controller: _phoneNumber,
                  textInputAction: TextInputAction.next,
                  decoration: authFieldDecoration(
                    context,
                    'Email or Phone number',
                  ),
                ),
                space16,

                space16,
                ActionButton(
                  text: context.localizations.signin,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      final username = _phoneNumber.text.trim();

                      context.read<AuthBloc>().signInStepOne(username);
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
