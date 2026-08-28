import 'dart:math' as math;

import 'package:edulab_b2b/widget_imports.dart';

/// Design tokens `border/soft` (#4E4E5F @ 25%) and `border/muted` (#4E4E5F @
/// 15%). The palette stores only the base colour — the opacity in its `//25%` /
/// `//15%` comments belongs at the use site, as elsewhere in the app.
Color _borderSoft(BuildContext context) =>
    context.colors.borderSoft.withOpacity(0.25);

Color _borderMuted(BuildContext context) =>
    context.colors.borderMuted.withOpacity(0.15);

/// White rounded card used for every block on the course page.
class CourseSectionCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? innerPadding;

  const CourseSectionCard({
    super.key,
    required this.child,
    this.innerPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      child: Container(
        width: double.infinity,
        clipBehavior: Clip.antiAlias,
        padding: innerPadding ?? EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: context.colors.bgSurface1,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: child,
      ),
    );
  }
}

class CourseSectionTitle extends StatelessWidget {
  final String text;

  const CourseSectionTitle(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    // Base/Headline 1: 16 / w500 / line-height 20 / letter-spacing -0.16.
    return Text(
      text,
      style: TextStyle(
        fontSize: 16.sp,
        height: 20 / 16,
        fontWeight: FontWeight.w500,
        letterSpacing: -0.16,
        color: context.colors.fgDefault,
      ),
    );
  }
}

/// Small dark badge (course type / "mandatory" style label).
class CoursePillBadge extends StatelessWidget {
  final String text;

  const CoursePillBadge({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      children: [
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
          decoration: BoxDecoration(
            color: isDark
                ? context.colors.neutralDefault
                : CustomThemes.neutral925,
            borderRadius: BorderRadius.circular(6.r),
          ),
          child: AppText.caption1(
            text,
            color: context.colors.accentOnAccent,
          ),
        ),
      ],
    );
  }
}

/// Circular avatar with an initials fallback.
class CourseCircleAvatar extends StatelessWidget {
  final String imageUrl;
  final String initials;
  final double size;

  const CourseCircleAvatar({
    super.key,
    required this.imageUrl,
    required this.initials,
    this.size = 36,
  });

  @override
  Widget build(BuildContext context) {
    final fallback = Container(
      width: size.w,
      height: size.w,
      alignment: Alignment.center,
      color: context.colors.neutralContainerDefault.withOpacity(0.1),
      child: AppText.caption1(
        initials,
        color: context.colors.neutralOnContainer,
      ),
    );

    return ClipOval(
      child: SizedBox(
        width: size.w,
        height: size.w,
        child: imageUrl.isEmpty
            ? fallback
            : CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => fallback,
                errorWidget: (context, url, error) => fallback,
              ),
      ),
    );
  }
}

String authorInitials(Authors author) {
  final first = author.firstname.isNotEmpty ? author.firstname[0] : '';
  final last = author.lastname.isNotEmpty ? author.lastname[0] : '';
  final result = (first + last).toUpperCase();
  return result.isEmpty ? '—' : result;
}

String authorFullName(Authors author) =>
    '${author.firstname} ${author.lastname}'.trim();

/// "What you'll learn" – tick-circle bullet list.
class WhatYouWillLearnSection extends StatelessWidget {
  final List<String> items;

  const WhatYouWillLearnSection({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return CourseSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CourseSectionTitle(context.localizations.whatUWillLearn),
          SizedBox(height: 12.h),
          for (var i = 0; i < items.length; i++) ...[
            if (i != 0) SizedBox(height: 12.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Assets.icons.courses.tickCircle.svg(
                  height: 20.w,
                  width: 20.w,
                  colorFilter: ColorFilter.mode(
                    context.colors.fgMuted,
                    BlendMode.srcIn,
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    items[i],
                    style: TextStyle(
                      fontSize: 14.sp,
                      height: 18 / 14,
                      color: context.colors.fgDefault,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

/// "Skills you'll gain" – wrap of light tag badges.
class SkillsYouWillGainSection extends StatelessWidget {
  final List<String> skills;

  const SkillsYouWillGainSection({super.key, required this.skills});

  @override
  Widget build(BuildContext context) {
    return CourseSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CourseSectionTitle(context.localizations.skillsYouWillGain),
          SizedBox(height: 12.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: [
              for (final skill in skills)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
                  decoration: BoxDecoration(
                    color: context.colors.neutralContainerDefault.withOpacity(
                      0.1,
                    ),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: AppText.caption1(
                    skill,
                    color: context.colors.neutralDefault,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

/// "About the course" – HTML body that collapses behind a gradient fade.
class AboutTheCourseSection extends StatelessWidget {
  final String html;
  final bool isCollapsed;
  final VoidCallback onToggle;

  const AboutTheCourseSection({
    super.key,
    required this.html,
    required this.isCollapsed,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final canExpand = html.length > 100;

    return CourseSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CourseSectionTitle(context.localizations.aboutTheCourse),
          SizedBox(height: 12.h),
          if (canExpand && isCollapsed)
            Stack(
              children: [
                ClipRect(
                  child: SizedBox(
                    height: 180.h,
                    width: double.infinity,
                    child: OverflowBox(
                      alignment: Alignment.topCenter,
                      minHeight: 0,
                      maxHeight: double.infinity,
                      child: HtmlWidget(html),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  height: 96.h,
                  child: IgnorePointer(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            context.colors.bgSurface1,
                            context.colors.bgSurface1.withOpacity(0),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          else
            HtmlWidget(html),
          if (canExpand) ...[
            SizedBox(height: 8.h),
            _ShowAllTextButton(
              isCollapsed: isCollapsed,
              onTap: onToggle,
            ),
          ],
        ],
      ),
    );
  }
}

class _ShowAllTextButton extends StatelessWidget {
  final bool isCollapsed;
  final VoidCallback onTap;

  const _ShowAllTextButton({required this.isCollapsed, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedRotation(
            turns: isCollapsed ? 0 : 0.5,
            duration: const Duration(milliseconds: 200),
            child: Assets.icons.courses.chevronDown.svg(
              height: 20.w,
              width: 20.w,
              colorFilter: ColorFilter.mode(
                context.colors.accentDefault,
                BlendMode.srcIn,
              ),
            ),
          ),
          SizedBox(width: 8.w),
          AppText.paragraph1(
            context.localizations.showAll,
            color: context.colors.accentDefault,
          ),
        ],
      ),
    );
  }
}

/// "Course content" – chapter accordion + "Show all" toggle.
class CourseContentSection extends StatelessWidget {
  final List<ChapterModel> chapters;
  final bool isCollapsed;
  final bool showToggle;
  final VoidCallback onToggle;

  const CourseContentSection({
    super.key,
    required this.chapters,
    required this.isCollapsed,
    required this.showToggle,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final visibleCount = isCollapsed
        ? math.min(3, chapters.length)
        : chapters.length;

    return CourseSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CourseSectionTitle(context.localizations.courseContent),
          SizedBox(height: 12.h),
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: _borderSoft(context))),
            ),
            child: Column(
              children: [
                for (var i = 0; i < visibleCount; i++)
                  CourseChapterAccordionItem(chapter: chapters[i]),
              ],
            ),
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

class CourseChapterAccordionItem extends StatefulWidget {
  final ChapterModel chapter;

  const CourseChapterAccordionItem({super.key, required this.chapter});

  @override
  State<CourseChapterAccordionItem> createState() =>
      _CourseChapterAccordionItemState();
}

class _CourseChapterAccordionItemState
    extends State<CourseChapterAccordionItem> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final chapter = widget.chapter;

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: _borderSoft(context))),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => setState(() => _expanded = !_expanded),
            behavior: HitTestBehavior.opaque,
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border(
                  bottom: _expanded
                      ? BorderSide(color: _borderSoft(context))
                      : BorderSide.none,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Base/Paragraph 1: 15 / w400 / line-height 20.
                          Text(
                            chapter.title,
                            style: TextStyle(
                              fontSize: 15.sp,
                              height: 20 / 15,
                              fontWeight: FontWeight.w400,
                              color: context.colors.fgDefault,
                            ),
                          ),
                          if (chapter.description.isNotEmpty) ...[
                            SizedBox(height: 4.h),
                            // Base/Subhead: 14 / w400 / line-height 18.
                            Text(
                              chapter.description,
                              style: TextStyle(
                                fontSize: 14.sp,
                                height: 18 / 14,
                                fontWeight: FontWeight.w400,
                                color: context.colors.fgMuted,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    SizedBox(width: 12.w),
                    AnimatedRotation(
                      turns: _expanded ? 0.5 : 0,
                      duration: const Duration(milliseconds: 200),
                      child: Assets.icons.courses.chevronDown.svg(
                        height: 24.w,
                        width: 24.w,
                        colorFilter: ColorFilter.mode(
                          context.colors.fgMuted,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox(width: double.infinity),
            secondChild: Padding(
              padding: EdgeInsets.only(left: 12.w, top: 12.h, bottom: 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Base/Paragraph 2: 14 / w400 / line-height 20.
                  for (final topic in chapter.topics)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: Text(
                        topic.title,
                        style: TextStyle(
                          fontSize: 14.sp,
                          height: 20 / 14,
                          fontWeight: FontWeight.w400,
                          color: context.colors.fgDefault,
                        ),
                      ),
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
      ),
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
          border: Border.all(color: _borderMuted(context)),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 15.sp,
            height: 20 / 15,
            fontWeight: FontWeight.w400,
            color: context.colors.neutralOnContainer,
          ),
        ),
      ),
    );
  }
}

/// "Instructors" – avatar, name/role, "N courses" pill and bio per author.
class InstructorsSection extends StatelessWidget {
  final List<Authors> authors;

  const InstructorsSection({super.key, required this.authors});

  @override
  Widget build(BuildContext context) {
    return CourseSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CourseSectionTitle(context.localizations.instructors),
          SizedBox(height: 12.h),
          for (var i = 0; i < authors.length; i++) ...[
            if (i != 0) SizedBox(height: 28.h),
            _InstructorBlock(author: authors[i]),
          ],
        ],
      ),
    );
  }
}

class _InstructorBlock extends StatelessWidget {
  final Authors author;

  const _InstructorBlock({required this.author});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CourseCircleAvatar(
              imageUrl: author.avatar?.originalUrl ?? '',
              initials: authorInitials(author),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.headline2(
                    authorFullName(author),
                    color: context.colors.fgDefault,
                    maxLines: 1,
                  ),
                  if (author.jobPosition.isNotEmpty)
                    AppText.caption1(
                      author.jobPosition,
                      color: context.colors.fgSoft,
                      maxLines: 1,
                    ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 10.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9999),
            border: Border.all(color: _borderMuted(context)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Assets.icons.courses.videoCircle.image(width: 16.w, height: 16.w),
              SizedBox(width: 4.w),
              AppText.caption1(
                '${author.courseCount} ${context.localizations.coursesWithnumber}',
                color: context.colors.fgDefault,
              ),
            ],
          ),
        ),
        if (author.about.isNotEmpty) ...[
          SizedBox(height: 16.h),
          Text(
            author.about,
            style: TextStyle(
              fontSize: 14.sp,
              height: 20 / 14,
              color: context.colors.fgDefault,
            ),
          ),
        ],
      ],
    );
  }
}

/// Opens the course preview video in a bottom sheet.
Future<void> showCoursePreviewSheet(BuildContext context, String url) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: context.colors.bgSurface1,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
    ),
    builder: (_) {
      return SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  behavior: HitTestBehavior.opaque,
                  child: Icon(Icons.close, color: context.colors.fgMuted),
                ),
              ),
              SizedBox(height: 8.h),
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: SimpleVideoPlayer(url: url),
              ),
            ],
          ),
        ),
      );
    },
  );
}
