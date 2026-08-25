import 'package:edulab_b2b/widget_imports.dart';

class SearchAndFilter extends StatelessWidget {
  final ValueChanged<String>? onChanged;

  const SearchAndFilter({super.key, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      decoration: BoxDecoration(
        color: context.colors.bgSurface1,
        borderRadius: BorderRadius.circular(100.r),
      ),
      child: Row(
        children: [
          SizedBox(width: 12.w),
          Assets.icons.courses.searchNormal.svg(
            colorFilter: ColorFilter.mode(
              context.colors.fgSoft,
              BlendMode.srcIn,
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: TextField(
              onChanged: onChanged,
              style: TextStyle(fontSize: 15.sp, color: context.colors.fgSoft),
              decoration: InputDecoration(
                hintText: context.localizations.search,
                border: InputBorder.none,
                isCollapsed: true,
                hintStyle: TextStyle(
                  fontSize: 15.sp,
                  color: context.colors.fgSoft,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
        ],
      ),
    );
  }
}
