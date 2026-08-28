import 'package:edulab_b2b/widget_imports.dart';

/// "Course content" tab of the enrolled-course page: a single white card with a
/// chapter accordion. Each open chapter lists its topics with a completion icon,
/// video / test counts and a tap target that resumes the topic in the player.
class EnrolledCourseContentCard extends StatelessWidget {
  final List<ChapterModel> chapters;
  final bool isCollapsed;
  final bool showToggle;
  final VoidCallback onToggle;
  final void Function(TopicModel topic) onOpenTopic;

  const EnrolledCourseContentCard({
    super.key,
    required this.chapters,
    required this.isCollapsed,
    required this.showToggle,
    required this.onToggle,
    required this.onOpenTopic,
  });

  @override
  Widget build(BuildContext context) {
    final visibleCount = isCollapsed
        ? (chapters.length < 3 ? chapters.length : 3)
        : chapters.length;

    return CourseSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var i = 0; i < visibleCount; i++)
            _ChapterAccordionItem(
              chapter: chapters[i],
              initiallyExpanded: i == 0,
              onOpenTopic: onOpenTopic,
            ),
          if (showToggle) ...[
            SizedBox(height: 12.h),
            _OutlinedShowAllButton(
              text: context.localizations.showAll,
              onTap: onToggle,
            ),
          ],
        ],
      ),
    );
  }
}

class _ChapterAccordionItem extends StatefulWidget {
  final ChapterModel chapter;
  final bool initiallyExpanded;
  final void Function(TopicModel topic) onOpenTopic;

  const _ChapterAccordionItem({
    required this.chapter,
    required this.initiallyExpanded,
    required this.onOpenTopic,
  });

  @override
  State<_ChapterAccordionItem> createState() => _ChapterAccordionItemState();
}

class _ChapterAccordionItemState extends State<_ChapterAccordionItem> {
  late bool _expanded = widget.initiallyExpanded;

  @override
  Widget build(BuildContext context) {
    final topics = widget.chapter.topics;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => setState(() => _expanded = !_expanded),
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Row(
              children: [
                AnimatedRotation(
                  turns: _expanded ? 0 : -0.25,
                  duration: const Duration(milliseconds: 200),
                  child: Assets.icons.courses.chevronDown.svg(
                    height: 16.w,
                    width: 16.w,
                    colorFilter: ColorFilter.mode(
                      context.colors.fgDefault,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    widget.chapter.title,
                    style: TextStyle(
                      fontSize: 15.sp,
                      height: 20 / 15,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.07,
                      color: context.colors.fgDefault,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        AnimatedCrossFade(
          firstChild: const SizedBox(width: double.infinity),
          secondChild: Padding(
            padding: EdgeInsets.only(left: 8.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final topic in topics)
                  _TopicRow(
                    topic: topic,
                    onOpen: () => widget.onOpenTopic(topic),
                  ),
              ],
            ),
          ),
          crossFadeState: _expanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 200),
        ),
      ],
    );
  }
}

class _TopicRow extends StatelessWidget {
  final TopicModel topic;
  final VoidCallback onOpen;

  const _TopicRow({required this.topic, required this.onOpen});

  bool get _isLocked => topic.status == 'CLOSED';
  bool get _isCompleted => topic.status == 'COMPLETED';

  int get _videoCount =>
      topic.steps.where((s) => s.type.toUpperCase() == 'VIDEO').length;

  int get _testCount =>
      topic.steps.where((s) => s.type.toUpperCase() == 'QUIZ').length;

  @override
  Widget build(BuildContext context) {
    final activityColor = _isLocked
        ? context.colors.neutralDefault
        : _isCompleted
        ? context.colors.successDefault
        : context.colors.accentDefault;

    return GestureDetector(
      onTap: _isLocked ? null : onOpen,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _statusIcon(context),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    topic.title,
                    style: TextStyle(
                      fontSize: 14.sp,
                      height: 20 / 14,
                      color: _isLocked
                          ? context.colors.fgDisabled.withOpacity(0.6)
                          : context.colors.fgDefault,
                    ),
                  ),
                ),
              ],
            ),
            if (_videoCount > 0 || _testCount > 0) ...[
              SizedBox(height: 8.h),
              Padding(
                padding: EdgeInsets.only(left: 28.w),
                child: Wrap(
                  spacing: 4.w,
                  runSpacing: 4.h,
                  children: [
                    if (_videoCount > 0)
                      _ActivityBadge(
                        label: context.localizations.videoCountShort(
                          _videoCount,
                        ),
                        color: activityColor,
                      ),
                    if (_testCount > 0)
                      _ActivityBadge(
                        label: context.localizations.testCountShort(_testCount),
                        color: activityColor,
                      ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _statusIcon(BuildContext context) {
    if (_isLocked) {
      return Assets.icons.learning.blocked.svg(
        height: 20.w,
        width: 20.w,
        colorFilter: ColorFilter.mode(
          context.colors.fgDisabled.withOpacity(0.6),
          BlendMode.srcIn,
        ),
      );
    }
    return (_isCompleted
            ? Assets.icons.learning.completed
            : Assets.icons.learning.active)
        .svg(height: 20.w, width: 20.w);
  }
}

class _ActivityBadge extends StatelessWidget {
  final String label;
  final Color color;

  const _ActivityBadge({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 16.h,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: AppText.caption3(label, color: color),
    );
  }
}

class _OutlinedShowAllButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const _OutlinedShowAllButton({required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 36.h,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.r),
          border: Border.all(color: context.colors.borderMuted),
        ),
        child: AppText.paragraph1(
          text,
          color: context.colors.neutralOnContainer,
        ),
      ),
    );
  }
}
