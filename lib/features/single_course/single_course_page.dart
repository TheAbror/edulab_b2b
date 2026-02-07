import 'package:leti_mobile/features/single_course/widgets/course_info_header.dart';
import 'package:leti_mobile/widget_imports.dart';

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

        return SingleChildScrollView(
          child: Column(
            children: [
              //HERE
              if (!widget.isContent) CourseInfoHeader(id: widget.id),
              //
              Padding(
                padding: EdgeInsets.only(top: 24.h, left: 16.w, right: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SkillLevelTimeToCompleteCertificatesPrereqs(state: state),

                    SizedBox(height: 24.h),

                    CourseInfoDivider(),

                    //studyGoals
                    if (state.singleCourse.syllabus?.studyGoals?.isNotEmpty ==
                        true) ...[
                      space24,
                      CourseInfoBlocsTitle(
                        text: context.localizations.whatUWillLearn,
                      ),
                      space16,
                      ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount:
                            state.singleCourse.syllabus?.studyGoals?.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return CourseInfoWhatYouWillLearnItems(
                            text:
                                state
                                    .singleCourse
                                    .syllabus
                                    ?.studyGoals?[index] ??
                                '',
                          );
                        },
                      ),
                      space24,
                    ],

                    // Course materials
                    if (!widget.isContent)
                      if (state
                              .singleCourse
                              .syllabus
                              ?.courseContent
                              ?.isNotEmpty ==
                          true) ...[
                        CourseInfoBlocsTitle(
                          text: context.localizations.courseMaterials,
                        ),
                        ExpandableCourseMaterials(state: state),
                        SizedBox(height: 16.h),
                        if (state.materialsMoreThan3)
                          ShowAllButtonWithChangingText(
                            isHidden: state.courseMaterialsAreHidden,
                            onTap: () {
                              context
                                  .read<SingleCourseBloc>()
                                  .manageCourseMaterials();
                            },
                          ),
                      ],

                    // skills
                    if (state.singleCourse.syllabus?.studyGoals?.isNotEmpty ==
                        true) ...[
                      SizedBox(height: 16.h),
                      CourseInfoBlocsTitle(
                        text: context.localizations.skilllsUWillGain,
                      ),
                      SizedBox(height: 16.h),
                      Wrap(
                        children: List.generate(
                          state.singleCourse.syllabus?.studyGoals?.length ?? 0,
                          (index) {
                            return Container(
                              margin: EdgeInsets.only(right: 8.w, bottom: 8.h),
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 5.h,
                              ),
                              decoration: BoxDecoration(
                                color: context.colors.neutralContainerDefault
                                    .withOpacity(0.1),
                                borderRadius: BorderRadius.circular(
                                  defaultRadius.r,
                                ),
                              ),
                              child: Text(
                                state
                                        .singleCourse
                                        .syllabus
                                        ?.studyGoals?[index] ??
                                    '',
                                style: TextStyle(fontSize: 12.sp),
                              ),
                            );
                          },
                        ),
                      ),
                      space24,
                    ],

                    if (state.singleCourse.description.isNotEmpty) ...[
                      CourseInfoBlocsTitle(
                        text: context.localizations.description,
                      ),
                      space8,
                      ExpandableHtml(
                        state: state,
                        html: state.singleCourse.description.first,
                      ),
                      space10,
                      ShowMoreTextWithOpacity(
                        text: 'Show all',
                        isDescriptionHidden: state.isDescriptionHidden,
                      ),
                      space24,
                    ],

                    //AUTHORS
                    if (state.singleCourse.authors.isNotEmpty) ...[
                      CourseInfoBlocsTitle(text: context.localizations.authors),
                      space16,
                      ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        itemCount: state.singleCourse.authors.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final item = state.singleCourse.authors[index];

                          return CourseInfoAuthorDetails(
                            onTap: () {},
                            authorName:
                                '${item.firstname}'
                                ' '
                                '${item.lastname}',
                            authorPhoto: item.avatar?.original_url ?? '',
                            authorPosition: item.jobPosition,
                            courseCount: item.courseCount,
                            about: item.about,
                          );
                        },
                      ),

                      SizedBox(height: 40.h),
                    ],
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
