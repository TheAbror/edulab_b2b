import 'package:edulab_b2b/widget_imports.dart';

class CourseCategoryChips extends StatelessWidget {
  final List<CategoryModel> categories;
  final int? selectedCategoryId;
  final ValueChanged<int?> onSelected;

  const CourseCategoryChips({
    super.key,
    required this.categories,
    required this.selectedCategoryId,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        itemCount: categories.length + 1,
        separatorBuilder: (context, index) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          final category = index == 0 ? null : categories[index - 1];
          final isSelected = selectedCategoryId == category?.id;
          final label = category?.title ?? context.localizations.all;

          return GestureDetector(
            onTap: () => onSelected(category?.id),
            behavior: HitTestBehavior.opaque,
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              decoration: BoxDecoration(
                color: isSelected
                    ? context.colors.accentDefault
                    : context.colors.neutralContainerDefault.withOpacity(0.1),
                borderRadius: BorderRadius.circular(100.r),
              ),
              child: AppText.paragraph1(
                label,
                color: isSelected
                    ? context.colors.accentOnAccent
                    : context.colors.fgDefault,
              ),
            ),
          );
        },
      ),
    );
  }
}
