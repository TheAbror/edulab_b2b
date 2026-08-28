import 'package:edulab_b2b/widget_imports.dart';

/// "My study" home section: section header, a paged carousel of resume cards
/// (the next card peeks in from the right) and a page control underneath.
class HomeMyStudySection extends StatefulWidget {
  final List<CourseShortInfo> courses;
  final VoidCallback onShowAll;
  final ValueChanged<CourseShortInfo> onContinue;

  const HomeMyStudySection({
    super.key,
    required this.courses,
    required this.onShowAll,
    required this.onContinue,
  });

  @override
  State<HomeMyStudySection> createState() => _HomeMyStudySectionState();
}

class _HomeMyStudySectionState extends State<HomeMyStudySection> {
  // Section margin (10 each side) + section padding (12 each side).
  static const _outerMargin = 10.0;
  static const _sectionPadding = 12.0;

  // Design leaves 22 of the next card visible, with a 4 gap between cards.
  static const _peek = 22.0;
  static const _cardGap = 4.0;

  late final PageController _controller;
  int _page = 0;

  @override
  void initState() {
    super.initState();

    final available =
        1.sw - (_outerMargin * 2).w - (_sectionPadding * 2).w;

    _controller = PageController(
      viewportFraction: ((available - _peek.w) / available).clamp(0.1, 1.0),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: _outerMargin.w),
      padding: EdgeInsets.all(_sectionPadding.w),
      decoration: BoxDecoration(
        color: context.colors.bgSurface1,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _sectionHeader(context),
          SizedBox(height: 10.h),
          SizedBox(height: 176.h, child: _cards()),
          if (widget.courses.length > 1) ...[
            SizedBox(height: 10.h),
            _pageControl(context),
          ],
        ],
      ),
    );
  }

  Widget _sectionHeader(BuildContext context) {
    return Container(
      height: 24.h,
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            context.localizations.myStudy,
            style: TextStyle(
              fontSize: 16.sp,
              height: 20 / 16,
              fontWeight: FontWeight.w500,
              letterSpacing: -0.16,
              color: context.colors.fgDefault,
            ),
          ),
          GestureDetector(
            onTap: widget.onShowAll,
            behavior: HitTestBehavior.opaque,
            child: Text(
              context.localizations.showAll,
              style: TextStyle(
                fontSize: 15.sp,
                height: 20 / 15,
                fontWeight: FontWeight.w500,
                color: context.colors.accentDefault,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cards() {
    // A lone card fills the section, so there is nothing to peek at.
    if (widget.courses.length == 1) return _card(widget.courses.first);

    return PageView.builder(
      controller: _controller,
      padEnds: false,
      itemCount: widget.courses.length,
      onPageChanged: (index) => setState(() => _page = index),
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.only(right: _cardGap.w),
        child: _card(widget.courses[index]),
      ),
    );
  }

  Widget _card(CourseShortInfo course) {
    return HomeCourseResumeCard(
      title: course.title,
      image: course.thumbnail?.originalUrl ?? '',
      progress: course.progess,
      buttonText: context.localizations.continueButton,
      onPressed: () => widget.onContinue(course),
    );
  }

  Widget _pageControl(BuildContext context) {
    final active = _page.clamp(0, widget.courses.length - 1);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.courses.length, (index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: (_cardGap / 2).w),
          height: 8.w,
          width: 8.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: context.colors.fgDefault.withOpacity(
              index == active ? 1 : 0.3,
            ),
          ),
        );
      }),
    );
  }
}
