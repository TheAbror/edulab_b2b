import 'package:edulab_b2b/widget_imports.dart';

class LearningBottomNavigation extends StatelessWidget {
  const LearningBottomNavigation({
    super.key,
    required this.controller,
    required this.stepsLength,
    required this.status,
    required this.stepModel,
    required this.courseId,
  });

  final TabController controller;
  final int stepsLength;
  final StepItemStatus status;
  final StepModel stepModel;
  final int courseId;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        bottom: 40.h,
      ),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: context.colors.borderMuted.withOpacity(0.15)),
        ),
      ),
      height: 100.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // PREV
          LearningBottomNavButtonLeft(
            onTap: () {
              final index = controller.index - 1;

              ///move to previous step
              if (controller.index > 0) {
                controller.animateTo(index);
                context.read<LearningBloc>().changeAppbarTabIndex(
                  index,
                  stepModel,
                );
              }

              ///move to previous topic
              if (controller.index == 0) {
                context.read<LearningBloc>().moveToPreviousTopic(
                  controller,
                  stepModel,
                );
              }
            },
            isEnabled: true,
            text: context.localizations.prev,
          ),

          Expanded(
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet<String>(
                  context: context,
                  useSafeArea: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      topRight: Radius.circular(20.r),
                    ),
                  ),
                  isScrollControlled: true,
                  builder: (context) {
                    return CourseContentBottomSheet(id: courseId);
                  },
                );
              },
              child: Container(
                height: 48.w,
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                margin: EdgeInsets.symmetric(horizontal: 8.w),
                decoration: BoxDecoration(
                  color: context.colors.neutralContainerDefault.withOpacity(
                    0.1,
                  ),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Row(
                  children: [
                    Assets.icons.menu.svg(),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Column(
                        children: [
                          AppText.footNote(
                            'Next: 1.4 The UI and UX Career Landscape?',
                            color: context.colors.fgDefault,
                          ),
                          AppText.caption3(
                            'Chapter 1 - Introduction to UI and UX Design',
                            color: context.colors.borderMuted,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // NEXT
          LearningBottomNavButtonRight(
            onTap: () {
              if (status == StepItemStatus.completed) {
                final index = controller.index + 1;

                if (controller.index < stepsLength - 1) {
                  controller.animateTo(index);
                  context.read<LearningBloc>().changeAppbarTabIndex(
                    index,
                    stepModel,
                  );
                }

                if (controller.index <= stepsLength - 1) {
                  if (stepsLength == index) {
                    context.read<LearningBloc>().moveToNextTopic(stepModel);
                    controller.index = 0;
                  }
                }

                context.read<QuizBloc>().clearAll();
              }
            },
            text: context.localizations.next,
          ),
        ],
      ),
    );
  }
}

class CourseContentBottomSheet extends StatefulWidget {
  final int id;

  const CourseContentBottomSheet({
    super.key,
    required this.id,
  });

  @override
  State<CourseContentBottomSheet> createState() =>
      _CourseContentBottomSheetState();
}

class _CourseContentBottomSheetState extends State<CourseContentBottomSheet> {
  final Set<int> _expandedChapters = {0}; // Chapter 1 expanded by default

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return BlocProvider(
          create: (context) => SingleCourseBloc()..getSingleCourse(widget.id),
          child: Column(
            children: [
              // Header
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 12.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: AppText.headline1(
                        'Introduction to UI and UX Design',
                        color: context.colors.fgDefault,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        height: 20.w,
                        width: 20.w,
                        decoration: BoxDecoration(
                          color: context.colors.neutralContainerDefault
                              .withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Icon(
                          Icons.close,
                          size: 18.r,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Divider(
                height: 1,
                color: context.colors.borderMuted.withOpacity(0.15),
              ),

              // Chapter list
              BlocBuilder<SingleCourseBloc, SingleCourseState>(
                builder: (context, state) {
                  return Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      itemCount: state.singleCourseChapters.length,
                      itemBuilder: (context, chapterIndex) {
                        final isExpanded = _expandedChapters.contains(
                          chapterIndex,
                        );

                        final item = state.singleCourseChapters[chapterIndex];

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Chapter header
                            InkWell(
                              onTap: () {
                                setState(() {
                                  if (isExpanded) {
                                    _expandedChapters.remove(chapterIndex);
                                  } else {
                                    _expandedChapters.add(chapterIndex);
                                  }
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20.w,
                                  vertical: 16.h,
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      isExpanded
                                          ? Icons.keyboard_arrow_down
                                          : Icons.keyboard_arrow_right,
                                      size: 22.r,
                                      color: Colors.black,
                                    ),
                                    SizedBox(width: 8.w),
                                    Expanded(
                                      child: AppText.headline2(
                                        item.title,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // Lessons (shown when expanded)
                            // if (isExpanded)
                            //   ...chapter.lessons.map(
                            //     (lesson) => _buildLessonTile(lesson),
                            //   ),
                            Divider(height: 1, color: Colors.grey[200]),
                          ],
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLessonTile(dynamic lesson) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 30.w),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              '${lesson.number} ${lesson.title}',
              style: TextStyle(
                fontSize: 14.sp,
                // color: lesson.status == LessonStatus.locked
                //     ? Colors.grey[400]
                //     : Colors.black87,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
