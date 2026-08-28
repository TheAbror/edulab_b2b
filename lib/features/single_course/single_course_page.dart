import 'package:edulab_b2b/features/single_course/widgets/course_info_header.dart';
import 'package:edulab_b2b/widget_imports.dart';

class SingleCoursePage extends StatelessWidget {
  final int id;

  const SingleCoursePage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final isRequested = context.read<CoursesBloc>().state.enrollmentStatus;

    return BlocProvider(
      create: (context) {
        final bloc = SingleCourseBloc();
        final bool? isAuthorized = PreferencesServices.getAuthStatus();

        if (isAuthorized == true) {
          bloc.getSingleCourse(id);
          bloc.manageRequested(isRequested == 'REQUESTED' ? true : false);
        } else {
          bloc.getSingleCourseAsUnathorized(id);
        }

        return bloc;
      },
      child: Scaffold(
        backgroundColor: context.colors.bgPage3,
        appBar: CourseInfoAppBar(id: id),
        body: SingleCourseBody(
          isContent: false,
          id: id,
        ),
      ),
    );
  }
}

class SingleCourseBody extends StatefulWidget {
  final bool isContent;
  final int id;

  const SingleCourseBody({
    super.key,
    required this.isContent,
    required this.id,
  });

  @override
  State<SingleCourseBody> createState() => SingleCourseBodyState();
}

class SingleCourseBodyState extends State<SingleCourseBody> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SingleCourseBloc, SingleCourseState>(
      listener: (context, state) {
        if (state.blocProgress == BlocProgress.FAILED) {
          showMessage(state.failureMessage, isError: true, context);
        }
      },
      builder: (context, state) {
        if (state.blocProgress == BlocProgress.IS_LOADING) {
          return const PrimaryLoader();
        }

        final course = state.singleCourse;
        final willLearn = course.willLearn ?? const [];
        final chapters = state.singleCourseChapters.isNotEmpty
            ? state.singleCourseChapters
            : (course.syllabus?.courseContent ?? const []);
        final skills = course.skills
            .map((s) => s.label)
            .where((label) => label.isNotEmpty)
            .toList();
        final instructors = <Authors>[...course.authors, ...course.co_authors];

        return SingleChildScrollView(
          child: Column(
            children: [
              if (!widget.isContent) CourseInfoHeader(id: widget.id),

              if (willLearn.isNotEmpty)
                WhatYouWillLearnSection(items: willLearn),

              if (!widget.isContent && chapters.isNotEmpty)
                CourseContentSection(
                  chapters: chapters,
                  isCollapsed: state.courseMaterialsAreHidden,
                  showToggle: state.materialsMoreThan3,
                  onToggle: () =>
                      context.read<SingleCourseBloc>().manageCourseMaterials(),
                ),

              if (skills.isNotEmpty) SkillsYouWillGainSection(skills: skills),

              if (course.aboutCourse.isNotEmpty)
                AboutTheCourseSection(
                  html: course.aboutCourse,
                  isCollapsed: state.isDescriptionHidden,
                  onToggle: () => context
                      .read<SingleCourseBloc>()
                      .manageDescriptionHidden(),
                ),

              if (instructors.isNotEmpty)
                InstructorsSection(authors: instructors),

              SizedBox(height: 24.h),
            ],
          ),
        );
      },
    );
  }
}
