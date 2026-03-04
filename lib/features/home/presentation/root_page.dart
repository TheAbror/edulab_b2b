import 'package:leti_mobile/features/home/presentation/widgets/no_internet_widget.dart';
import 'package:leti_mobile/widget_imports.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> with WidgetsBindingObserver {
  late PageController pageController;
  late StreamSubscription<bool> notAuthorizedStreamSubscription;

  List<Widget> pages = [
    HomeTab(),
    LearningTab(),
    CoursesTab(),
    const ProfileTab(),
  ];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    final bool? isAuthorized = PreferencesServices.getAuthStatus();

    notAuthorizedStreamSubscription = ApiProvider
        .notAuthorizedInterceptor
        .controller
        .stream
        .listen(
          (bool isNotAuthorized) {
            if (isNotAuthorized) {
              if (!mounted) return;

              if (!context.mounted) return;
              ApiProvider.create();

              PreferencesServices.clearAll();

              context.read<AuthBloc>().clearAll();
              context.read<HomeBloc>().clearAll();
              context.read<CoursesBloc>().clearAll();
              context.read<LearningTabBloc>().clearAll();
              context.read<SplashBloc>().clearAll();
              context.read<ProfileBloc>().clearAll();
              context.read<LocalizationBloc>().clearAll();

              Navigator.pushNamed(context, AppRoutes.languageSelectionPage);
            }
          },
        );

    if (isAuthorized == true) {
      context.read<CoursesBloc>().getAllCourses();
      context.read<LearningTabBloc>().getInProgress();
      context.read<LearningTabBloc>().getCompleted();
      context.read<LearningTabBloc>().getStatistics();
    } else {
      context.read<CoursesBloc>().getAllCoursesAsUnauthorized();
    }

    final state = context.read<HomeBloc>().state;
    pageController = PageController(initialPage: state.tabIndex);
  }

  // ignore: unused_field
  bool _isInBackground = false;

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _isInBackground = state != AppLifecycleState.resumed;

    if (state == AppLifecycleState.resumed) {
      context.read<HomeBloc>().checkConnection();
    }
  }

  bool _isDialogShowing = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) async {
        if (state.internetStatus == InternetStatus.disconnected &&
            !_isDialogShowing) {
          await Future.delayed(const Duration(seconds: 1));

          if (!context.mounted) return;

          if (context.read<HomeBloc>().state.internetStatus ==
              InternetStatus.disconnected) {
            _isDialogShowing = true;
            await showNoInternetDialog(context);
            _isDialogShowing = false;
          }
        }

        if (state.internetStatus == InternetStatus.connected &&
            _isDialogShowing) {
          _isDialogShowing = false;
          if (!context.mounted) return;
          Navigator.of(context, rootNavigator: true).pop();
        }
      },
      builder: (context, state) {
        return DefaultTabController(
          length: 2,
          child: WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
              appBar: _appBar(context, state.tabIndex) as PreferredSizeWidget,
              body: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: pageController,
                children: [pages[state.tabIndex]],
              ),
              bottomNavigationBar: HomeBottomNavigation(
                tabIndex: state.tabIndex,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _appBar(context, selectedIndex) {
    final bool? isAuthorized = PreferencesServices.getAuthStatus();

    if (selectedIndex == 1 && isAuthorized == true) {
      return LearningTabAppBar();
    }
    if (selectedIndex == 2) {
      return CoursesTabAppBar();
    }
    if (selectedIndex == 3) {
      return PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).padding.top),
        child: SizedBox(height: MediaQuery.of(context).padding.top),
      );
    } else {
      return PreferredSize(
        preferredSize: Size.fromHeight(0.0),
        child: Container(),
      );
    }
  }
}
