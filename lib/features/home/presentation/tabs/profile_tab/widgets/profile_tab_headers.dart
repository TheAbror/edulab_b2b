import 'package:leti_mobile/widget_imports.dart';

Widget ProfileTabSubHeader(
  BuildContext context,
  String text,
  VoidCallback onTap, {
  String? selectedResult,
}) {
  return GestureDetector(
    onTap: onTap,
    behavior: HitTestBehavior.opaque,
    child: Container(
      margin: EdgeInsets.only(bottom: 16.h),
      child: Row(
        children: [
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            selectedResult ?? '',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: context.colors.fgMuted,
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

Padding ProfileTabHeader(String text, BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(bottom: 12.h),
    child: Text(
      text,
      style: TextStyle(
        color: context.colors.fgMuted,
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}
