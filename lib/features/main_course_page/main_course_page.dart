import 'package:leti_mobile/features/main_course_page/appbar/course_content_sliver_appbar.dart';
import 'package:leti_mobile/widget_imports.dart';

class EnrolledCoursePage extends StatefulWidget {
  final int id;

  const EnrolledCoursePage({super.key, required this.id});

  @override
  State<EnrolledCoursePage> createState() => _EnrolledCoursePageState();
}

class _EnrolledCoursePageState extends State<EnrolledCoursePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SingleCourseBloc()..getSingleCourseByItsId(widget.id),
      child: Scaffold(
        body: BlocBuilder<SingleCourseBloc, SingleCourseState>(
          builder: (context, state) {
            if (state.blocProgress == BlocProgress.IS_LOADING) {
              return const PrimaryLoader();
            }

            return DefaultTabController(
              length: 3,
              child: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[
                        CourseContentSliverAppBar(course: state.fullCourseInfo),
                        SliverPersistentHeader(
                          delegate: SliverAppBarDelegate(
                            TabBar(
                              unselectedLabelColor: Theme.of(
                                context,
                              ).colorScheme.secondaryContainer,
                              labelColor: Theme.of(context).colorScheme.primary,
                              indicatorColor: Theme.of(
                                context,
                              ).colorScheme.primary,
                              dividerColor: context.colors.borderMuted
                                  .withOpacity(0.15),
                              tabs: const [
                                Tab(child: TabText(text: 'Info')),
                                Tab(child: TabText(text: 'Content')),
                                Tab(child: TabText(text: 'News')),
                              ],
                            ),
                          ),
                        ),
                      ];
                    },
                body: TabBarView(
                  children: [
                    CourseContentTabInfo(),
                    SingleCourseContent(state: state),
                    CourseContentTabNews(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
