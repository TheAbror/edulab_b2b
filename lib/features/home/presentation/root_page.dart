import 'package:leti_mobile/features/home/presentation/widgets/no_internet_widget.dart';
import 'package:leti_mobile/widget_imports.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
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
      context.read<CoursesBloc>().getCurrentCourse();
      context.read<LearningTabBloc>().getInProgress();
      context.read<LearningTabBloc>().getCompleted();
      context.read<LearningTabBloc>().getStatistics();
    } else {
      context.read<CoursesBloc>().getAllCoursesAsUnauthorized();
    }

    final state = context.read<HomeBloc>().state;
    pageController = PageController(initialPage: state.tabIndex);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state.internetStatus == InternetStatus.disconnected) {
          return showNoInternetDialog(context);
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
