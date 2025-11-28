import 'package:leti_mobile/widget_imports.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  late PageController pageController;

  List<Widget> pages = [
    HomeTab(),
    LearningTab(),
    CoursesTab(),
    const ProfileTab(),
  ];

  @override
  void initState() {
    super.initState();

    // context.read<HomeBloc>().getTeachersList();
    context.read<CoursesBloc>().getAllCategories();
    context.read<CoursesBloc>().getAllPossibleCourses();
    context.read<CoursesBloc>().getCurrentCourse();
    context.read<LearningTabBloc>().getInProgress();
    context.read<LearningTabBloc>().getCompleted();
    context.read<LearningTabBloc>().getFavorites();
    context.read<LearningTabBloc>().getStatistics();

    final state = context.read<HomeBloc>().state;
    pageController = PageController(initialPage: state.tabIndex);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return DefaultTabController(
          length: 4,
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
    if (selectedIndex == 1) {
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
