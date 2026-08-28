import 'package:edulab_b2b/widget_imports.dart';

/// "My-study-card": course thumbnail + title, progress bar and a filled
/// Continue pill. Fixed 176h so the inner blocks distribute exactly like the
/// design regardless of whether the title wraps to one or two lines.
class HomeCourseResumeCard extends StatelessWidget {
  final String title;
  final int progress;
  final String buttonText;
  final VoidCallback onPressed;
  final String image;

  const HomeCourseResumeCard({
    super.key,
    required this.title,
    required this.progress,
    required this.buttonText,
    required this.onPressed,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 176.h,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: context.colors.bgSurface1,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: context.colors.borderMuted.withOpacity(0.15),
          width: 1.w,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _header(context),
          _progress(context),
          _continueButton(context),
        ],
      ),
    );
  }

  Widget _header(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: _thumbnail(context),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 15.sp,
                  height: 20 / 15,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.07,
                  color: context.colors.fgDefault,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _thumbnail(BuildContext context) {
    // Courses without a thumbnail go straight to the fallback instead of
    // asking the cache manager to fetch an empty URL.
    if (image.isEmpty) return _thumbnailFallback(context);

    return CachedNetworkImage(
      imageUrl: image,
      height: 40.h,
      width: 46.w,
      fit: BoxFit.cover,
      placeholder: (context, url) => Container(
        height: 40.h,
        width: 46.w,
        color: context.colors.bgSurface3,
      ),
      errorWidget: (context, url, error) => _thumbnailFallback(context),
    );
  }

  Widget _thumbnailFallback(BuildContext context) {
    return Container(
      height: 40.h,
      width: 46.w,
      decoration: BoxDecoration(
        color: context.colors.neutralContainerDefault.withOpacity(0.1),
        image: DecorationImage(
          image: AssetImage('assets/images/network_image_error_case.png'),
        ),
      ),
    );
  }

  Widget _progress(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                context.localizations.courseProgress,
                style: TextStyle(
                  color: context.colors.fgMuted,
                  fontSize: 12.sp,
                  height: 14 / 12,
                  letterSpacing: 0.2,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              '$progress%',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: context.colors.fgMuted,
                fontSize: 12.sp,
                height: 14 / 12,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.h),
        LinearProgressIndicator(
          minHeight: 4.h,
          value: (progress / 100).clamp(0.0, 1.0),
          color: context.colors.accentDefault,
          backgroundColor: context.colors.bgSurface3,
          borderRadius: BorderRadius.circular(10.r),
        ),
      ],
    );
  }

  Widget _continueButton(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 36.h,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
          color: context.colors.accentDefault,
          borderRadius: BorderRadius.circular(999.r),
        ),
        child: Text(
          buttonText,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 15.sp,
            height: 20 / 15,
            color: context.colors.accentOnAccent,
          ),
        ),
      ),
    );
  }
}
