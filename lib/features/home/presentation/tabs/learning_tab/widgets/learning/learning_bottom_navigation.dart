import 'package:edulab_b2b/widget_imports.dart';

class LearningBottomNavigation extends StatelessWidget {
  const LearningBottomNavigation({
    super.key,
    required this.controller,
    required this.stepsLength,
    required this.status,
    required this.stepModel,
    required this.courseId,
    required this.state,
  });

  final TabController controller;
  final int stepsLength;
  final StepItemStatus status;
  final StepModel stepModel;
  final int courseId;
  final LearningState state;

  @override
  Widget build(BuildContext context) {
    final next = _nextTopic(state);

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
              behavior: HitTestBehavior.opaque,
              onTap: () => _openCourseContentSheet(context),
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
                    Assets.icons.menu.svg(
                      width: 20.w,
                      height: 20.w,
                      colorFilter: ColorFilter.mode(
                        context.colors.fgDefault,
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText.footNote(
                            next == null
                                ? state.topic.title
                                : '${context.localizations.next}: ${next.title}',
                            color: context.colors.fgDefault,
                            maxLines: 1,
                          ),
                          AppText.caption3(
                            next?.chapterTitle ?? state.chapter.title,
                            color: context.colors.borderMuted,
                            maxLines: 1,
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

  void _openCourseContentSheet(BuildContext context) {
    final bloc = context.read<LearningBloc>();

    showModalBottomSheet<void>(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      backgroundColor: context.colors.bgSurface1,
      barrierColor: const Color(0xFF101013).withOpacity(0.7),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (_) => BlocProvider.value(
        value: bloc,
        child: const CourseContentBottomSheet(),
      ),
    );
  }

  ({String title, String chapterTitle})? _nextTopic(LearningState state) {
    final chapters = state.resumedCourse.chapters;
    final chapterIndex = chapters.indexWhere((c) => c.id == state.chapter.id);
    if (chapterIndex < 0) return null;

    final topics = chapters[chapterIndex].topics;
    final topicIndex = topics.indexWhere((t) => t.id == state.topic.id);
    if (topicIndex < 0) return null;

    // Next topic inside the current chapter.
    if (topicIndex + 1 < topics.length) {
      return (
        title: topics[topicIndex + 1].title,
        chapterTitle: chapters[chapterIndex].title,
      );
    }

    // Otherwise the first topic of the next non-empty chapter.
    for (var i = chapterIndex + 1; i < chapters.length; i++) {
      if (chapters[i].topics.isNotEmpty) {
        return (
          title: chapters[i].topics.first.title,
          chapterTitle: chapters[i].title,
        );
      }
    }

    return null;
  }
}

class CourseContentBottomSheet extends StatefulWidget {
  const CourseContentBottomSheet({super.key});

  @override
  State<CourseContentBottomSheet> createState() =>
      _CourseContentBottomSheetState();
}

class _CourseContentBottomSheetState extends State<CourseContentBottomSheet> {
  late final Set<int> _expandedChapters;

  @override
  void initState() {
    super.initState();
    final state = context.read<LearningBloc>().state;
    final activeChapter = state.resumedCourse.chapters.indexWhere(
      (c) => c.id == state.chapter.id,
    );
    _expandedChapters = {activeChapter < 0 ? 0 : activeChapter};
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.78,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return BlocBuilder<LearningBloc, LearningState>(
          builder: (context, state) {
            final chapters = state.resumedCourse.chapters;

            return Column(
              children: [
                _Header(title: state.resumedCourse.title),
                Divider(
                  height: 1,
                  thickness: 1,
                  color: context.colors.borderMuted.withOpacity(0.15),
                ),
                Expanded(
                  child: chapters.isEmpty
                      ? const SizedBox()
                      : ListView.builder(
                          controller: scrollController,
                          padding: EdgeInsets.symmetric(vertical: 20.h),
                          itemCount: chapters.length,
                          itemBuilder: (context, index) => _ChapterTile(
                            chapter: chapters[index],
                            isExpanded: _expandedChapters.contains(index),
                            activeTopicId: state.topic.id,
                            onToggle: () => setState(() {
                              _expandedChapters.contains(index)
                                  ? _expandedChapters.remove(index)
                                  : _expandedChapters.add(index);
                            }),
                            onTopicTap: (topic) {
                              final bloc = context.read<LearningBloc>();
                              Navigator.pop(context);
                              if (topic.id != state.topic.id) {
                                bloc.openTopic(chapters[index], topic);
                              }
                            },
                          ),
                        ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: AppText.headline1(
              title,
              color: context.colors.fgDefault,
              maxLines: 1,
            ),
          ),
          SizedBox(width: 12.w),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            behavior: HitTestBehavior.opaque,
            child: Container(
              height: 24.w,
              width: 24.w,
              decoration: BoxDecoration(
                color: context.colors.neutralContainerDefault.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: Icon(
                Icons.close,
                size: 16.r,
                color: context.colors.fgDefault,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChapterTile extends StatelessWidget {
  const _ChapterTile({
    required this.chapter,
    required this.isExpanded,
    required this.activeTopicId,
    required this.onToggle,
    required this.onTopicTap,
  });

  final ChapterModel chapter;
  final bool isExpanded;
  final int activeTopicId;
  final VoidCallback onToggle;
  final ValueChanged<TopicModel> onTopicTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: onToggle,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: Row(
              children: [
                Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_down_rounded
                      : Icons.keyboard_arrow_right_rounded,
                  size: 16.r,
                  color: context.colors.fgDefault,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: AppText.headline2(
                    chapter.title,
                    color: context.colors.fgDefault,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (isExpanded)
          Padding(
            padding: EdgeInsets.only(left: 38.w, right: 10.w),
            child: Column(
              children: chapter.topics
                  .map(
                    (topic) => _TopicTile(
                      topic: topic,
                      isCurrent: topic.id == activeTopicId,
                      onTap: () => onTopicTap(topic),
                    ),
                  )
                  .toList(),
            ),
          ),
      ],
    );
  }
}

class _TopicTile extends StatelessWidget {
  const _TopicTile({
    required this.topic,
    required this.isCurrent,
    required this.onTap,
  });

  final TopicModel topic;
  final bool isCurrent;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isClosed = !isCurrent && topic.status == 'CLOSED';
    final isCompleted = !isCurrent && topic.status == 'COMPLETED';

    return GestureDetector(
      onTap: isClosed ? null : onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _statusIcon(context, isClosed: isClosed, isCompleted: isCompleted),
            SizedBox(width: 8.w),
            Expanded(
              child: AppText.paragraph2(
                topic.title,
                color: isClosed
                    ? context.colors.fgDisabled
                    : context.colors.fgDefault,
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statusIcon(
    BuildContext context, {
    required bool isClosed,
    required bool isCompleted,
  }) {
    if (isCompleted) {
      return Assets.icons.learning.completed.svg(width: 20.w, height: 20.w);
    }
    if (isClosed) {
      return Assets.icons.learning.blocked.svg(
        width: 20.w,
        height: 20.w,
        colorFilter: ColorFilter.mode(
          context.colors.fgDisabled.withOpacity(0.6),
          BlendMode.srcIn,
        ),
      );
    }
    return Assets.icons.learning.active.svg(width: 20.w, height: 20.w);
  }
}
