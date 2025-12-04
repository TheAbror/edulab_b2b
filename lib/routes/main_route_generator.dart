import 'package:leti_mobile/widget_imports.dart';

class MainRouteGenerator {
  Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splashPage:
        return CustomCupertinoStyleNavigationRoute(
          builder: (_) => const SplashPage(),
        );

      case AppRoutes.welcomePage:
        return CustomCupertinoStyleNavigationRoute(
          builder: (_) => const WelcomePage(),
        );

      case AppRoutes.languageSelectionPage:
        return CustomCupertinoStyleNavigationRoute(
          builder: (_) => const LanguageSelectionPage(),
        );

      case AppRoutes.signUpPage:
        return CustomCupertinoStyleNavigationRoute(
          builder: (_) => const SignUpPage(),
        );

      case AppRoutes.signInPageStepTwo:
        return CustomCupertinoStyleNavigationRoute(
          builder: (_) {
            return const SignInPageStepTwo();
          },
        );

      case AppRoutes.singUpEnterDetailsPage:
        return CustomCupertinoStyleNavigationRoute(
          builder: (_) => const SignUpEnterDetailsPage(),
        );

      case AppRoutes.signInPageStepOne:
        return CustomCupertinoStyleNavigationRoute(
          builder: (_) => const SignInPageStepOne(),
        );

      case AppRoutes.forgotPasswordPage:
        return CustomCupertinoStyleNavigationRoute(
          builder: (_) => const ForgotPasswordPage(),
        );

      case AppRoutes.forgotPasswordSetNewPassword:
        return CustomCupertinoStyleNavigationRoute(
          builder: (_) => const ForgotPasswordNewPasswordPage(),
        );

      case AppRoutes.forgotPasswordResetPage:
        return CustomCupertinoStyleNavigationRoute(
          builder: (_) => const ForgotPasswordResetPage(),
        );

      case AppRoutes.rootPage:
        return CustomCupertinoStyleNavigationRoute(
          builder: (_) => const RootPage(),
        );

      case AppRoutes.profileTab:
        return CustomCupertinoStyleNavigationRoute(
          builder: (_) => const ProfileTab(),
        );

      case AppRoutes.editProfilePage:
        return CustomCupertinoStyleNavigationRoute(
          builder: (_) => EditProfilePage(),
        );

      case AppRoutes.frequentlyAskedQuestionsPage:
        return CustomCupertinoStyleNavigationRoute(
          builder: (_) => FrequentlyAskedQuestionsPage(),
        );

      case AppRoutes.certificatesPage:
        return CustomCupertinoStyleNavigationRoute(
          builder: (_) => CertificatesPage(),
        );

      case AppRoutes.accountSecurityPage:
        return CustomCupertinoStyleNavigationRoute(
          builder: (_) => AccountSecurityPage(),
        );

      case AppRoutes.privacySettingsPage:
        return CustomCupertinoStyleNavigationRoute(
          builder: (_) => PrivacySettingsPage(),
        );

      case AppRoutes.homeTab:
        return CustomCupertinoStyleNavigationRoute(builder: (_) => HomeTab());

      case AppRoutes.authorProfilePage:
        return CustomCupertinoStyleNavigationRoute(
          builder: (_) {
            // final teacherName = state.extra as String? ?? 'Teacher';
            const teacherName = 'Teacher';

            return AuthorProfilePage(teacherName: teacherName);
          },
        );

      case AppRoutes.studentProfilePage:
        return CustomCupertinoStyleNavigationRoute(
          builder: (_) {
            // final teacherName = state.extra as String? ?? 'Teacher';
            const teacherName = 'Teacher';

            return StudentProfilePage(teacherName: teacherName);
          },
        );

      case AppRoutes.learningPage:
        return CustomCupertinoStyleNavigationRoute(
          builder: (_) => LearningPage(id: settings.arguments as int),
        );

      case AppRoutes.chatPage:
        return CustomCupertinoStyleNavigationRoute(builder: (_) => ChatPage());

      case AppRoutes.allCoursesPage:
        return CustomCupertinoStyleNavigationRoute(
          builder: (_) =>
              AllCoursesPage(idAndTitle: settings.arguments as IdAndTitle?),
        );

      case AppRoutes.singleCoursePageForRecommended:
        return CustomCupertinoStyleNavigationRoute(
          builder: (_) => SingleCoursePage(id: settings.arguments as int),
        );

      case AppRoutes.singleCoursePage:
        return CustomCupertinoStyleNavigationRoute(
          builder: (_) => SingleCoursePage(id: settings.arguments as int),
        );

      case AppRoutes.webView:
        return CustomCupertinoStyleNavigationRoute(
          builder: (_) => WebViewPage(),
        );

      case AppRoutes.enrolledCoursePage:
        return CustomCupertinoStyleNavigationRoute(
          builder: (_) => EnrolledCoursePage(id: settings.arguments as int),
        );

      case AppRoutes.allCategoriesPage:
        return CustomCupertinoStyleNavigationRoute(
          builder: (_) => AllCategoriesPage(),
        );

      default:
        return CustomCupertinoStyleNavigationRoute(
          builder: (_) => const SplashPage(),
        );
    }
  }
}
