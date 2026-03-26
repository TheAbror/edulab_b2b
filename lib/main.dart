import 'package:leti_mobile/widget_imports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PreferencesServices.init();

  ApiProvider.create();

  /// For logging
  setUpLogging();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((
    _,
  ) {
    runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => AuthBloc()),
          BlocProvider(create: (_) => SplashBloc()),
          BlocProvider(create: (_) => CoursesBloc()),
          BlocProvider(create: (_) => LearningTabBloc()),
          BlocProvider(create: (_) => QuizBloc()),
          BlocProvider(create: (_) => LearningBloc()),
          BlocProvider(create: (_) => HomeBloc()..initialTheme()),
          BlocProvider(create: (_) => LocalizationBloc()..initLocalization()),
        ],
        child: MyApp(),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationBloc, LocalizationState>(
      builder: (context, localizationState) {
        return BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: ScreenUtilInit(
                designSize: const Size(360, 812),
                minTextAdapt: true,
                splitScreenMode: true,
                builder: (sizesContext, child) {
                  return MaterialApp(
                    theme: state.isLightTheme == true
                        ? lightTheme()
                        : darkTheme(),
                    themeMode: ThemeMode.system,
                    debugShowCheckedModeBanner: false,
                    onGenerateRoute: MainRouteGenerator().generateRoute,
                    builder: BotToastInit(),
                    navigatorObservers: [BotToastNavigatorObserver()],
                    locale:
                        localizationState.languageCode != null &&
                            localizationState.languageCode?.isNotEmpty == true
                        ? Locale(localizationState.languageCode ?? '')
                        : Locale('ru'),
                    localizationsDelegates:
                        AppLocalizations.localizationsDelegates,
                    supportedLocales: AppLocalizations.supportedLocales,
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
