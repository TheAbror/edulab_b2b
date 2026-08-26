import 'package:edulab_b2b/features/home/presentation/tabs/profile_tab/widgets/profile_tab_languages.dart';
import 'package:edulab_b2b/widget_imports.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(),
      child: _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var lang = context.localizations;

    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      children: [
        //! Profile card
        ProfileTabAppBar(),
        space24,

        //! Settings
        ProfileTabHeader(lang.staffSettings, context),
        space12,

        //! Video preferences
        ProfileTabSectionCard(
          context,
          caption: lang.videoPreferences,
          items: [
            ProfileTabSectionItem(
              context,
              title: lang.downloadOptions,
              onTap: () {},
            ),
            ProfileTabSectionItem(
              context,
              title: lang.videoPlayBackOptions,
              onTap: () {},
            ),
          ],
        ),
        space12,

        //! Account settings
        BlocBuilder<LocalizationBloc, LocalizationState>(
          builder: (context, localizationState) {
            return BlocBuilder<HomeBloc, HomeState>(
              builder: (context, homeState) {
                return ProfileTabSectionCard(
                  context,
                  caption: lang.accountSettings,
                  items: [
                    ProfileTabSectionItem(
                      context,
                      title: lang.language,
                      value: returnLanguageName(
                        localizationState.languageCode ?? '',
                      ),
                      onTap: () => languageSelectionDialog(context),
                    ),
                    ProfileTabSectionItem(
                      context,
                      title: lang.theme,
                      value: homeState.isLightTheme ? lang.light : lang.dark,
                      onTap: () => themeSelectionDialog(context),
                    ),
                  ],
                );
              },
            );
          },
        ),
        space12,

        //! Help and support
        ProfileTabSectionCard(
          context,
          caption: lang.helpAndSupport,
          items: [
            ProfileTabSectionItem(
              context,
              title: lang.frequesntlyAskedQuestions,
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.frequentlyAskedQuestionsPage,
                );
              },
            ),
            ProfileTabSectionItem(
              context,
              title: lang.aboutEdulab,
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.aboutEdulabPage);
              },
            ),
          ],
        ),
        space24,

        ProfileTabLogOutButton(),
        space20,
      ],
    );
  }
}
