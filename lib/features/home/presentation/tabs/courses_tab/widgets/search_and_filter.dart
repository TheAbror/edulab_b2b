import 'package:edulab_b2b/widget_imports.dart';

class SearchAndFilter extends StatefulWidget {
  const SearchAndFilter({super.key});

  @override
  State<SearchAndFilter> createState() => _SearchAndFilterState();
}

class _SearchAndFilterState extends State<SearchAndFilter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: context.colors.borderMuted.withOpacity(0.15),
          width: 2.w,
        ),
      ),
      child: Row(
        children: [
          SizedBox(width: 12.w),
          Assets.icons.courses.searchNormal.svg(
            colorFilter: ColorFilter.mode(
              context.colors.fgDefault,
              BlendMode.srcIn,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: TextField(
              style: TextStyle(color: context.colors.fgSoft),
              decoration: InputDecoration(
                hintText: context.localizations.search,
                border: InputBorder.none,
                hintStyle: TextStyle(color: context.colors.fgSoft),
              ),
            ),
          ),
          SizedBox(width: 10.w),
          GestureDetector(
            onTap: () async {
              final result = await FilterCoursesBottomSheet.show(context);

              print(result);
            },
            behavior: HitTestBehavior.opaque,
            child: Assets.icons.courses.courseSettigns.svg(
              colorFilter: ColorFilter.mode(
                context.colors.fgDefault,
                BlendMode.srcIn,
              ),
            ),
          ),
          SizedBox(width: 12.w),
        ],
      ),
    );
  }
}
