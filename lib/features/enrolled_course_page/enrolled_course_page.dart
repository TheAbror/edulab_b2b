import 'package:edulab_b2b/features/enrolled_course_page/widgets/course_segment_control.dart';
import 'package:edulab_b2b/features/enrolled_course_page/widgets/enrolled_course_content_card.dart';
import 'package:edulab_b2b/features/enrolled_course_page/widgets/enrolled_course_header_card.dart';
import 'package:edulab_b2b/features/enrolled_course_page/widgets/youre_enrolled_card.dart';
import 'package:edulab_b2b/widget_imports.dart';

class EnrolledCoursePage extends StatelessWidget {
  final int id;

  const EnrolledCoursePage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SingleCourseBloc()..getSingleCourse(id),
      child: Scaffold(
        backgroundColor: context.colors.bgPage3,
        appBar: CourseInfoAppBar(id: id),
        body: _EnrolledCourseBody(id: id),
      ),
    );
  }
}

class _EnrolledCourseBody extends StatefulWidget {
  final int id;

  const _EnrolledCourseBody({required this.id});

  @override
  State<_EnrolledCourseBody> createState() => _EnrolledCourseBodyState();
}

class _EnrolledCourseBodyState extends State<_EnrolledCourseBody> {
  // 0 = Course content, 1 = About course.
  int _segment = 0;

  void _openLearning(BuildContext context, {CurrentlyActive? ids}) {
    Navigator.pushNamed(
      context,
      AppRoutes.learningPage,
      arguments: OpenCourseByTopicSelectionModel(courseID: widget.id, ids: ids),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SingleCourseBloc, SingleCourseState>(
      listener: (context, state) {
        if (state.blocProgress == BlocProgress.FAILED) {
          showMessage(state.failureMessage, isError: true, context);
        }

        if (state.navigateToLearning) {
          _openLearning(
            context,
            ids: CurrentlyActive(
              chapterID: state.lastStoppedStep?.chapterID ?? 0,
              topicID: state.lastStoppedStep?.topicID ?? 0,
              stepID: state.lastStoppedStep?.stepID ?? 0,
            ),
          );
          context.read<SingleCourseBloc>().manageNavigateToLearning(false);
        }
      },
      builder: (context, state) {
        if (state.blocProgress == BlocProgress.IS_LOADING) {
          return const PrimaryLoader();
        }

        final course = state.singleCourse;
        final chapters = state.singleCourseChapters.isNotEmpty
            ? state.singleCourseChapters
            : (course.syllabus?.courseContent ?? const <ChapterModel>[]);

        return RefreshIndicator(
          onRefresh: () async =>
              context.read<SingleCourseBloc>().getSingleCourse(widget.id),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EnrolledCourseHeaderCard(
                  course: course,
                  onContinue: () => _openLearning(context),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 10.w,
                    right: 10.w,
                    top: 16.h,
                    bottom: 4.h,
                  ),
                  child: CourseSegmentControl(
                    segments: [
                      context.localizations.courseContent,
                      context.localizations.aboutCourse,
                    ],
                    selectedIndex: _segment,
                    onChanged: (i) => setState(() => _segment = i),
                  ),
                ),
                if (_segment == 0)
                  _buildContent(context, state, chapters)
                else
                  _buildAbout(),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildContent(
    BuildContext context,
    SingleCourseState state,
    List<ChapterModel> chapters,
  ) {
    if (chapters.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 32.h),
        child: Center(
          child: AppText.paragraph1(context.localizations.noResults),
        ),
      );
    }

    return EnrolledCourseContentCard(
      chapters: chapters,
      isCollapsed: state.courseMaterialsAreHidden,
      showToggle: state.materialsMoreThan3,
      onToggle: () => context.read<SingleCourseBloc>().manageCourseMaterials(),
      onOpenTopic: (topic) {
        if (topic.status == 'CLOSED' || topic.steps.isEmpty) return;
        context.read<SingleCourseBloc>().openSelectedTopic(
          courseId: topic.courseId ?? widget.id,
          ids: CurrentlyActive(
            chapterID: topic.chapterId ?? 0,
            topicID: topic.id,
            stepID: topic.steps.first.id,
          ),
        );
      },
    );
  }

  Widget _buildAbout() {
    return Column(
      children: [
        const YoureEnrolledCard(),
        SingleCourseBody(isContent: true, id: widget.id),
      ],
    );
  }
}
