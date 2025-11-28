import 'package:leti_mobile/widget_imports.dart';

class FilterCoursesBottomSheetTile extends StatelessWidget {
  final String title;
  final List<String> children;
  final bool isTopic;
  final bool isLevel;
  final bool isLanguage;

  const FilterCoursesBottomSheetTile({
    super.key,
    required this.title,
    required this.children,
    this.isTopic = false,
    this.isLevel = false,
    this.isLanguage = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomSheetFilterBloc, BottomSheetFilterState>(
      builder: (context, state) {
        return ExpansionTile(
          key: GlobalKey(),
          initiallyExpanded: isTopic
              ? state.isTopicTileOpen
              : isLevel
              ? state.isLevelTileOpen
              : state.isLanguageTileOpen,
          title: Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              letterSpacing: -0.5,
            ),
          ),
          shape: const Border(),
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Wrap(
                  children: List.generate(
                    state.isAllTopicsShown
                        ? children.length
                        : (children.length < 6 ? children.length : 6),
                    (index) {
                      bool isSelected = isLanguage
                          ? state.listOfSelectedLanguageIndexes.contains(index)
                          : isTopic
                          ? state.listOfSelectedTopicIndexes.contains(index)
                          : state.listOfSelectedLevelIndexes.contains(index);

                      Color backgroundColor = isSelected
                          ? Theme.of(context).colorScheme.primary
                          : context.colors.neutralContainerDefault.withOpacity(
                              0.1,
                            );

                      Color textColor = isSelected
                          ? context.colors.float
                          : context.colors.fgDefault;

                      return GestureDetector(
                        onTap: () {
                          if (isLanguage) {
                            context
                                .read<BottomSheetFilterBloc>()
                                .addToSelectedLanguageList(index);
                          } else if (isTopic) {
                            context
                                .read<BottomSheetFilterBloc>()
                                .addToSelectedTopicList(index);
                          } else {
                            context
                                .read<BottomSheetFilterBloc>()
                                .addToSelectedLevelList(index);
                          }
                        },
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          margin: EdgeInsets.only(right: 8.w, bottom: 8.h),
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 6.h,
                          ),
                          decoration: BoxDecoration(
                            color: backgroundColor,
                            borderRadius: BorderRadius.circular(50.r),
                          ),
                          child: Text(
                            children[index],
                            style: TextStyle(fontSize: 15.sp, color: textColor),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            if (!state.isAllTopicsShown && children.length > 6)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
                child: CourseInfoShowAllButton(
                  onTap: () {
                    context.read<BottomSheetFilterBloc>().isAllItemsShown();
                  },
                ),
              ),
          ],
          onExpansionChanged: (val) {
            if (isLanguage) {
              context.read<BottomSheetFilterBloc>().controlLanguageExpansion(
                val,
              );
            } else if (isTopic) {
              context.read<BottomSheetFilterBloc>().controlTopicExpansion(val);
            } else {
              context.read<BottomSheetFilterBloc>().controlLevelExpansion(val);
            }
            context.read<BottomSheetFilterBloc>().expandBottomSheet(1.0);
          },
        );
      },
    );
  }
}
