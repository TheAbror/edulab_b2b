import 'package:edulab_b2b/features/enrolled_course_page/appbar/enrolled_course_sliver_appbar.dart';
import 'package:edulab_b2b/widget_imports.dart';

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
      create: (context) => SingleCourseBloc()..getSingleCourse(widget.id),
      child: Scaffold(
        body: BlocConsumer<SingleCourseBloc, SingleCourseState>(
          listener: (context, state) {
            if (state.navigateToLearning) {
              Navigator.pushNamed(
                context,
                AppRoutes.learningPage,
                arguments: OpenCourseByTopicSelectionModel(
                  courseID: state.courseID,
                  ids: CurrentlyActive(
                    chapterID: state.lastStoppedStep?.chapterID ?? 0,
                    topicID: state.lastStoppedStep?.topicID ?? 0,
                    stepID: state.lastStoppedStep?.stepID ?? 0,
                  ),
                ),
              );

              context.read<SingleCourseBloc>().manageNavigateToLearning(false);
            }
          },
          builder: (context, state) {
            if (state.blocProgress == BlocProgress.IS_LOADING) {
              return const PrimaryLoader();
            }

            return DefaultTabController(
              length: 2,
              initialIndex: 1,
              child: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[
                        EnrolledCourseSliverAppBar(course: state.singleCourse),
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
                              tabs: [
                                Tab(
                                  child: TabText(
                                    text: context.localizations.info,
                                  ),
                                ),
                                Tab(
                                  child: TabText(
                                    text: context.localizations.content,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ];
                    },
                body: TabBarView(
                  children: [
                    CourseContentTabInfo(id: widget.id),
                    SingleCourseContent(state: state),
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
