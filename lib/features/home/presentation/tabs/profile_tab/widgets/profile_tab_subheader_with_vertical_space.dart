import 'package:edulab_b2b/widget_imports.dart';

Widget ProfileTabSubHeaderWithVerticalSpace(
  BuildContext context,
  String text,
  VoidCallback onTap, {
  String? selectedResult,
}) {
  return GestureDetector(
    onTap: onTap,
    behavior: HitTestBehavior.opaque,
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 250.w,
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16.sp,
                height: 1.2,
                fontWeight: FontWeight.w400,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(width: 20.w),
          Assets.icons.learning.arrowRight.svg(
            colorFilter: ColorFilter.mode(
              Theme.of(context).colorScheme.surfaceTint,
              BlendMode.srcIn,
            ),
          ),
        ],
      ),
    ),
  );
}
