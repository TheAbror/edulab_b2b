import 'package:leti_mobile/widget_imports.dart';

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
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular((defaultRadius * 2).r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4.r),
                child: CachedNetworkImage(
                  imageUrl: image,
                  height: 40.h,
                  width: 46.w,
                  fit: BoxFit.fill,
                  placeholder: (context, url) => Container(
                    height: 40.h,
                    width: 46.w,
                    color: Colors.grey[200],
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  errorWidget: (context, url, error) => Container(
                    height: 40.h,
                    width: 46.w,
                    decoration: BoxDecoration(
                      color: context.colors.neutralContainerDefault.withOpacity(
                        0.1,
                      ),
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/network_image_error_case.png',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              SizedBox(
                width: 231.w,
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.7,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.localizations.courseProgress,
                style: TextStyle(
                  color: context.colors.fgMuted,
                  fontSize: 12.sp,
                  letterSpacing: -0.5,
                ),
              ),
              Text(
                '$progress%',
                style: TextStyle(
                  color: context.colors.fgMuted,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          LinearProgressIndicator(
            minHeight: 4.h,
            value: progress.toDouble() / 100,
            color: Theme.of(context).colorScheme.primary,
            backgroundColor: context.colors.bgSurface3,
            borderRadius: BorderRadius.circular(10.r),
          ),
          SizedBox(height: 12.h),
          GestureDetector(
            onTap: onPressed,
            behavior: HitTestBehavior.opaque,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 6.h),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.all(Radius.circular(6.r)),
                border: Border.all(
                  color: context.colors.accentMuted,
                  width: 2.w,
                ),
              ),
              child: Center(
                child: Text(
                  buttonText,
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
