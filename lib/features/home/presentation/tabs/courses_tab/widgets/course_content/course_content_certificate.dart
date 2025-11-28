import 'package:leti_mobile/widget_imports.dart';

class CourseContentCertificated extends StatelessWidget {
  final String shareText;
  final String headline;
  final String subTitle;
  final String result;
  final VoidCallback onTap;

  const CourseContentCertificated({
    super.key,
    required this.shareText,
    required this.headline,
    required this.subTitle,
    required this.result,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 234.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      headline,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    space8,
                    SizedBox(
                      width: 176.w,
                      child: Text(
                        subTitle,
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                          color: context.colors.fgMuted,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    space8,
                    Text(
                      result,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: context.colors.fgSoft,
                      ),
                    ),
                  ],
                ),
              ),
              Assets.icons.courses.certificate.image(width: 82.w, height: 64.h),
            ],
          ),
          space20,
          GestureDetector(
            onTap: onTap,
            behavior: HitTestBehavior.opaque,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 6.h),
              width: double.infinity,
              decoration: BoxDecoration(
                color: context.colors.accentContainerDefault.withOpacity(0.1),
                borderRadius: BorderRadius.all(
                  Radius.circular(defaultRadius.r),
                ),
              ),
              child: Row(
                children: [
                  Spacer(),
                  Assets.icons.courses.shareIcon.svg(
                    height: 24.w,
                    width: 24.w,
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    shareText,
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
