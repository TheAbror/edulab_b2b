import 'package:leti_mobile/widget_imports.dart';

class EnterDetailsPage extends StatelessWidget {
  const EnterDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
  final _formKey = GlobalKey<FormState>();
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.blocProgress == BlocProgress.IS_SUCCESS) {
          context.read<AuthBloc>().setInitialValue();

          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.rootPage,
            (route) => false,
          );
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

                TextFormField(
                  controller: _firstName,
                  textInputAction: TextInputAction.next,
                  decoration: authFieldDecoration(
                    context,
                    context.localizations.firstName,
                  ),
                  onChanged: (value) {
                    context.read<AuthBloc>().saveFirstName(value);
                  },
                ),
                space12,

                TextFormField(
                  controller: _lastName,
                  textInputAction: TextInputAction.next,
                  decoration: authFieldDecoration(
                    context,
                    context.localizations.lastName,
                  ),
                  onChanged: (value) {
                    context.read<AuthBloc>().saveLastName(value);
                  },
                ),

                space32,
                ActionButton(
                  isDisabled: !state.isFirstAndLastNameValid,
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
}
