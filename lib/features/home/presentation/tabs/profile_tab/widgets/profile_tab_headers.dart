import 'package:edulab_b2b/widget_imports.dart';

Padding ProfileTabHeader(String text, BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(
      bottom: 8.h,
      left: 16.w,
    ),
    child: Text(
      text.toUpperCase(),
      style: TextStyle(
        color: context.colors.fgMuted,
        fontSize: 13.sp,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.2,
      ),
    ),
  );
}

Widget ProfileTabSectionCard(
  BuildContext context, {
  required String caption,
  required List<Widget> items,
}) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 10.h),
    decoration: BoxDecoration(
      color: context.colors.bgSurface1,
      borderRadius: BorderRadius.circular(16.r),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          caption.toUpperCase(),
          style: TextStyle(
            color: context.colors.fgMuted,
            fontSize: 11.sp,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.3,
          ),
        ),
        SizedBox(height: 6.h),
        for (var i = 0; i < items.length; i++)
          Container(
            decoration: i == 0
                ? null
                : BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: context.colors.borderMuted.withOpacity(0.15),
                      ),
                    ),
                  ),
            child: items[i],
          ),
      ],
    ),
  );
}

Widget ProfileTabSectionItem(
  BuildContext context, {
  required String title,
  String? value,
  required VoidCallback onTap,
  int maxLines = 1,
}) {
  return GestureDetector(
    onTap: onTap,
    behavior: HitTestBehavior.opaque,
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: context.colors.fgDefault,
                height: 1.25,
              ),
              maxLines: maxLines,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (value != null) ...[
            Text(
              value,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: context.colors.fgMuted,
              ),
            ),
            SizedBox(width: 20.w),
          ],
          Assets.icons.learning.arrowRight.svg(
            width: 20.w,
            height: 20.w,
            colorFilter: ColorFilter.mode(
              context.colors.fgMuted,
              BlendMode.srcIn,
            ),
          ),
        ],
      ),
    ),
  );
}
