import 'package:leti_mobile/features/home/presentation/tabs/profile_tab/widgets/profile_tab_languages.dart';
import 'package:leti_mobile/widget_imports.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => ProfileBloc(), child: _Body());
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var lang = context.localizations;

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //! AppBar
            ProfileTabAppBar(),

            //! Video preferences
            ProfileTabHeader(lang.videoPreferences, context),
            ProfileTabSubHeader(context, lang.downloadOptions, () {}),
            ProfileTabSubHeader(context, lang.videoPlayBackOptions, () {}),
            space24,

            //! Account settings
            ProfileTabHeader(lang.accountSettings, context),

            BlocBuilder<LocalizationBloc, LocalizationState>(
              builder: (context, localizationState) {
                return ProfileTabSubHeader(
                  context,
                  lang.language,
                  () => languageSelectionDialog(context),
                  selectedResult: returnLanguageName(
                    localizationState.languageCode ?? '',
                  ),
                );
              },
            ),
            space24,

            //! Appearance
            ProfileTabHeader(lang.appearance, context),
            ProfileTabSubHeader(
              context,
              lang.theme,
              () => themeSelectionDialog(context),
            ),
            space24,

            //! Help and support
            ProfileTabHeader(lang.helpAndSupport, context),
            ProfileTabSubHeader(context, lang.frequesntlyAskedQuestions, () {
              Navigator.pushNamed(
                context,
                AppRoutes.frequentlyAskedQuestionsPage,
              );
            }),
            ProfileTabSubHeader(context, lang.aboutEdulab, () {}),

            space24,
            ProfileTabLogOutButton(),
            space40,
          ],
        ),
      ),
    );
  }
}
