import 'package:leti_mobile/widget_imports.dart';

class FilterCoursesBottomSheet extends StatefulWidget {
  const FilterCoursesBottomSheet({super.key});

  static Future<String?> show(BuildContext parentContext) async {
    return showModalBottomSheet<String>(
      context: parentContext,
      useSafeArea: true,
      backgroundColor: Theme.of(parentContext).colorScheme.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      isScrollControlled: true,
      builder: (context) {
        return BlocProvider(
          create: (context) => BottomSheetFilterBloc(),
          child: FilterCoursesBottomSheet(),
        );
      },
    );
  }

  @override
  State<FilterCoursesBottomSheet> createState() =>
      _FilterCoursesBottomSheetState();
}

class _FilterCoursesBottomSheetState extends State<FilterCoursesBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomSheetFilterBloc, BottomSheetFilterState>(
      builder: (context, state) {
        final areValuesSelected =
            state.listOfSelectedLanguageIndexes.isNotEmpty ||
            state.listOfSelectedLevelIndexes.isNotEmpty ||
            state.listOfSelectedTopicIndexes.isNotEmpty ||
            state.isCertificateSwitchOn ||
            state.isFreeCourseSwitchOn;

        return AnimatedContainer(
          duration: Duration(milliseconds: 300),
          height: MediaQuery.of(context).size.height * state.heightRatio,
          child: Stack(
            children: [
              FractionallySizedBox(
                heightFactor: 1,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CourseAllCategoiesBottomSheetTopIcons(),
                      Divider(
                        height: 2.h,
                        thickness: 1.h,
                        color: context.colors.borderMuted.withOpacity(0.15),
                      ),
                      BlocBuilder<CoursesBloc, CoursesState>(
                        builder: (context, state) {
                          return FilterCoursesBottomSheetTile(
                            title: context.localizations.categories,
                            isTopic: true,
                            children: state.categories
                                .map((e) => e.title)
                                .toList(),
                          );
                        },
                      ),
                      _divider(context),
                      FilterCoursesBottomSheetTile(
                        title: context.localizations.level,
                        isLevel: true,
                        children: const [],
                      ),
                      _divider(context),
                      FilterCourseBottomSheetSwitch(
                        switchValue: state.isCertificateSwitchOn,
                        title: context.localizations.withCertificate,
                        onSwitchChanged: (bool value) {
                          context
                              .read<BottomSheetFilterBloc>()
                              .changeCertificateSwitch(value);
                        },
                      ),
                      _divider(context),
                      FilterCourseBottomSheetSwitch(
                        switchValue: state.isFreeCourseSwitchOn,
                        title: context.localizations.onlyFree,
                        onSwitchChanged: (bool value) {
                          context
                              .read<BottomSheetFilterBloc>()
                              .changeFreeCourseSwitch(value);
                        },
                      ),
                      _divider(context),
                      FilterCoursesBottomSheetTile(
                        title: context.localizations.language,
                        isLanguage: true,
                        children: const [],
                      ),
                      _divider(context),

                      areValuesSelected
                          ? _clearFilters(context)
                          : SizedBox.shrink(),
                      space24,
                      // Extra space to ensure bottom content is not covered
                      SizedBox(
                        height: MediaQuery.of(context).viewInsets.bottom + 60.h,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 30.h,
                left: 16.w,
                right: 16.w,
                child: areValuesSelected
                    ? _showAllButton(context)
                    : SizedBox.shrink(),
              ),
            ],
          ),
        );
      },
    );
  }

  GestureDetector _clearFilters(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<BottomSheetFilterBloc>().clearBottomSheetValues();
      },
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Row(
          children: [
            Assets.icons.courses.refreshIcon.svg(),
            SizedBox(width: 8.w),
            Text(
              context.localizations.clearFilter,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: context.colors.infoDefault,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _showAllButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.all(Radius.circular(defaultRadius.r)),
      ),
      child: Center(
        child: Text(
          context.localizations.showAll,
          style: TextStyle(
            fontSize: 16.sp,
            color: context.colors.float,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _divider(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Divider(
        height: 2.h,
        thickness: 1.h,
        color: context.colors.borderMuted.withOpacity(0.15),
      ),
    );
  }
}
