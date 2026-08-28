import 'package:edulab_b2b/widget_imports.dart';

/// First card on the enrolled-course page: thumbnail + title, short description,
/// course-type badge, completion progress and the "Continue" action.
class EnrolledCourseHeaderCard extends StatelessWidget {
  final SingleCourseInfo course;
  final VoidCallback onContinue;

  const EnrolledCourseHeaderCard({
    super.key,
    required this.course,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    final typeLabel = course.type?.label ?? '';
    final progress = (course.progress ?? 0).clamp(0, 100);

    return CourseSectionCard(
      innerPadding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: context.colors.borderMuted.withOpacity(0.15),
                ),
              ),
            ),
            child: Row(
              children: [
                _Thumbnail(url: course.thumbnail?.originalUrl ?? ''),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    course.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 17.sp,
                      height: 22 / 17,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.17,
                      color: context.colors.fgDefault,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (course.shortDescription.isNotEmpty) ...[
                  Text(
                    course.shortDescription,
                    style: TextStyle(
                      fontSize: 14.sp,
                      height: 18 / 14,
                      color: context.colors.fgSoft,
                    ),
                  ),
                  SizedBox(height: 10.h),
                ],
                if (typeLabel.isNotEmpty) ...[
                  CoursePillBadge(text: typeLabel),
                  SizedBox(height: 24.h),
                ],
                Text(
                  context.localizations.percentComplete(progress),
                  style: TextStyle(
                    fontSize: 14.sp,
                    height: 18 / 14,
                    color: context.colors.fgDefault,
                  ),
                ),
                SizedBox(height: 10.h),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: LinearProgressIndicator(
                    minHeight: 4.h,
                    value: progress / 100,
                    color: context.colors.accentDefault,
                    backgroundColor: context.colors.neutralContainerDefault
                        .withOpacity(0.1),
                  ),
                ),
                SizedBox(height: 24.h),
                _ContinueButton(onTap: onContinue),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Thumbnail extends StatelessWidget {
  final String url;

  const _Thumbnail({required this.url});

  @override
  Widget build(BuildContext context) {
    final placeholder = Container(
      color: context.colors.neutralContainerDefault.withOpacity(0.1),
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(6.r),
      child: SizedBox(
        width: 62.w,
        height: 48.h,
        child: url.isEmpty
            ? placeholder
            : CachedNetworkImage(
                imageUrl: url,
                fit: BoxFit.cover,
                placeholder: (context, _) => placeholder,
                errorWidget: (context, _, __) => placeholder,
              ),
      ),
    );
  }
}

class _ContinueButton extends StatelessWidget {
  final VoidCallback onTap;

  const _ContinueButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 48.h,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9999),
          border: Border.all(color: context.colors.accentMuted),
        ),
        child: Text(
          context.localizations.continueButton,
          style: TextStyle(
            fontSize: 16.sp,
            height: 20 / 16,
            fontWeight: FontWeight.w500,
            letterSpacing: -0.16,
            color: context.colors.accentOnContainer,
          ),
        ),
      ),
    );
  }
}
