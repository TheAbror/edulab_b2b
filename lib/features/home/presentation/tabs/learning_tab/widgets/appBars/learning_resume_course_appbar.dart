import 'package:leti_mobile/widget_imports.dart';

class LearningResumeCourseAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const LearningResumeCourseAppBar({
    super.key,
    required this.state,
    required this.controller,
    required this.title,
    required this.steps,
  });

  final LearningState state;
  final TabController controller;
  final String title;
  final List<StepModel> steps;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      titleSpacing: 0,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
            icon: Assets.icons.main.arrowBack.svg(
              colorFilter: ColorFilter.mode(
                context.colors.fgDefault,
                BlendMode.srcIn,
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Center(
            child: SizedBox(
              width: 256.w,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -1,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Spacer(),
          Assets.icons.courses.moreIcon.svg(
            colorFilter: ColorFilter.mode(
              context.colors.fgDefault,
              BlendMode.srcIn,
            ),
          ),
          SizedBox(width: 16.w),
        ],
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(48.h),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: context.colors.borderMuted.withOpacity(0.15),
                ),
                bottom: BorderSide(
                  color: state.isExpanded
                      ? context.colors.borderMuted.withOpacity(0.15)
                      : Colors.transparent,
                ),
              ),
            ),
            child: BlocBuilder<LearningBloc, LearningState>(
              builder: (context, innerState) {
                return TabBar(
                  tabAlignment: TabAlignment.start,
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  indicatorColor: Colors.transparent,
                  labelPadding: EdgeInsets.only(left: 4.w),
                  dividerColor: Colors.transparent,
                  isScrollable: true,
                  controller: controller,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: BoxDecoration(
                    border: Border.all(
                      width: 2.w,
                      color: context.colors.accentMuted,
                    ),
                    color: context.colors.accentContainerDefault.withOpacity(
                      0.1,
                    ),
                    borderRadius: BorderRadius.circular(50.r),
                  ),
                  tabs: steps.asMap().entries.map((entry) {
                    final index = entry.key;
                    final step = entry.value;

                    return _customTab(
                      _getStepIcon(
                        step,
                        index,
                        // innerState.currentTabIndex,
                        controller.index,
                        context,
                      ),
                      context,
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _getStepIcon(
    StepModel step,
    int index,
    int currentTabIndex,
    BuildContext context,
  ) {
    final bool isActive = index == currentTabIndex;
    // final Color activeColor = context.colors.fgDisabled.withOpacity(0.4);
    // final Color inactiveColor = context.colors.fgDefault;
    final Color activeColor = context.colors.fgDefault; // active = prominent
    final Color inactiveColor = context.colors.fgDisabled.withOpacity(
      0.4,
    ); // inactive = lighter

    if (step.type == 'TEXT' || step.type == 'text') {
      return Assets.icons.learning.text.svg(
        colorFilter: ColorFilter.mode(
          isActive ? activeColor : inactiveColor,
          BlendMode.srcIn,
        ),
      );
    } else if (step.type == 'VIDEO' || step.type == 'video') {
      return Assets.icons.learning.currentVideoIcon.svg(
        colorFilter: ColorFilter.mode(
          isActive ? activeColor : inactiveColor,
          BlendMode.srcIn,
        ),
      );
    } else if (step.type == 'QUIZ' || step.type == 'quiz') {
      return Assets.icons.learning.questionMarkIcon.svg(
        colorFilter: ColorFilter.mode(
          isActive ? activeColor : inactiveColor,
          BlendMode.srcIn,
        ),
      );
    } else if (step.type == 'DOCUMENT' || step.type == 'text') {
      return Assets.icons.learning.currentVideoIcon.svg(
        colorFilter: ColorFilter.mode(
          isActive ? activeColor : inactiveColor,
          BlendMode.srcIn,
        ),
      );
    } else {
      return Assets.icons.learning.questionMarkIcon.svg(
        colorFilter: ColorFilter.mode(
          isActive ? activeColor : inactiveColor,
          BlendMode.srcIn,
        ),
      );
    }
  }

  Widget _customTab(Widget widget, BuildContext context) {
    return Container(
      height: 32.h,
      width: 48.w,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: context.colors.containerDefault.withOpacity(0.1),
        borderRadius: BorderRadius.circular(50.r),
      ),
      child: widget,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 48.h);
}
