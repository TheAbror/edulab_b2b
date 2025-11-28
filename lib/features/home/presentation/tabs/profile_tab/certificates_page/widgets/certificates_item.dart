import 'package:leti_mobile/widget_imports.dart';
import 'package:share_plus/share_plus.dart';

class CertificatesItem extends StatelessWidget {
  final String text;
  final String certificateUrl;
  final String grade;
  final String? buttonText;

  const CertificatesItem({
    super.key,
    required this.text,
    required this.certificateUrl,
    required this.grade,
    this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      margin: EdgeInsets.only(bottom: 12.h, right: 16.w, left: 16.w),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: context.colors.borderMuted.withOpacity(0.15),
          width: 2.w,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              SizedBox(
                width: 235.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text,
                      style: TextStyle(fontWeight: FontWeight.w700),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    space8,
                    Text(
                      grade,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 11.sp,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Assets.icons.courses.certificate.image(width: 61.w, height: 48.h),
            ],
          ),
          space36,
          GestureDetector(
            onTap: () {
              Share.share('check out my website https://example.com');
            },
            behavior: HitTestBehavior.opaque,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.r),
                border: Border.all(
                  color: context.colors.accentMuted,
                  width: 2.w,
                ),
              ),
              child: Center(
                child: Text(
                  buttonText ?? 'Share certificate',
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
