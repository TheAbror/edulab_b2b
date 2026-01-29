import 'package:leti_mobile/features/auth/presentation/login_page/login_page.dart';
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

      case AppRoutes.codeVerificationPage:
        return CustomCupertinoStyleNavigationRoute(
          builder: (_) {
            return const CodeVerificationPage();
          },
        );

      case AppRoutes.enterDetailsPage:
        return CustomCupertinoStyleNavigationRoute(
          builder: (_) => const EnterDetailsPage(),
        );

      case AppRoutes.loginPage:
        return CustomCupertinoStyleNavigationRoute(
          builder: (_) => const LoginPage(),
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
          builder: (_) => LearningPage(
            args: settings.arguments as OpenCourseByTopicSelectionModel,
          ),
        );

      case AppRoutes.chatPage:
        return CustomCupertinoStyleNavigationRoute(builder: (_) => ChatPage());

      case AppRoutes.allCoursesPage:
        return CustomCupertinoStyleNavigationRoute(
          builder: (_) =>
              AllCoursesPage(idAndTitle: settings.arguments as IdAndTitle?),
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
