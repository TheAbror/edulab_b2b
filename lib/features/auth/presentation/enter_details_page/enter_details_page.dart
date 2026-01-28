import 'package:leti_mobile/widget_imports.dart';

class EnterDetailsPage extends StatelessWidget {
  const EnterDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();

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
                space4,
                AppText.paragraph1(
                  context.localizations.pleseEnterFirstLastName,
                  color: context.colors.fgMuted,
                ),
                space24,

                _firstNameField(context),
                space12,

                _lastNameField(context),

                space32,
                ActionButton(
                  isDisabled: false,
                  text: context.localizations.startlearning,
                  onTap: () {
                    final firstName = _firstName.text.trim();
                    final lastName = _lastName.text.trim();

                    if (_formKey.currentState!.validate()) {
                      context.read<AuthBloc>().signInStepThree(
                        firstName,
                        lastName,
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
      controller: _firstName,
      textInputAction: TextInputAction.next,
      decoration: authFieldDecoration(context, context.localizations.firstName),
    );
  }

  TextFormField _lastNameField(BuildContext context) {
    return TextFormField(
      controller: _lastName,
      textInputAction: TextInputAction.next,
      decoration: authFieldDecoration(context, context.localizations.lastName),
    );
  }
}
