import 'package:leti_mobile/widget_imports.dart';

class LearningResumeCourseAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const LearningResumeCourseAppBar({
    super.key,
    required this.state,
    required this.controller,
    required this.title,
    required this.steps,
    required this.currentStatus,
  });

  final LearningState state;
  final TabController controller;
  final String title;
  final List<StepModel> steps;
  final StepItemStatus currentStatus;

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
                  onTap: (value) {
                    final tappedStatus = state.allSteps[value].status;
                    final currentIndex = controller.previousIndex;
                    final currentStatus = state.allSteps[currentIndex].status;
                    final isNextStep = value == currentIndex + 1;

                    if (tappedStatus == StepItemStatus.completed ||
                        tappedStatus == StepItemStatus.active ||
                        (currentStatus == StepItemStatus.completed &&
                            isNextStep)) {
                      context.read<LearningBloc>().changeAppbarTabIndex(
                        value,
                        StepModel.initial(),
                      );
                    } else {
                      controller.index = currentIndex;
                    }
                  },
                  tabAlignment: TabAlignment.start,
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  indicatorColor: Colors.transparent,
                  labelPadding: EdgeInsets.only(left: 4.w),
                  dividerColor: Colors.transparent,
                  isScrollable: true,
                  controller: controller,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: const BoxDecoration(),
                  // Pass index and state into _customTab
                  tabs: steps.asMap().entries.map((entry) {
                    final index = entry.key;
                    final step = entry.value;
                    final isSelected =
                        index ==
                        innerState.appbarTabIndex; // use innerState, not state
                    final isCompleted = step.status == StepItemStatus.completed;

                    return _customTab(
                      _getStepIcon(
                        step,
                        index,
                        innerState.appbarTabIndex,
                        context,
                        isCompleted,
                      ),
                      context,
                      isSelected: isSelected,
                      isCompleted: isCompleted,
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
    bool isCompleted,
  ) {
    final bool isActive = index == currentTabIndex;

    final Color activeColor = context.colors.fgDefault;
    final Color completed = context.colors.status01OnContainer;
    final Color inactiveColor = context.colors.fgDisabled.withOpacity(
      0.4,
    );

    if (step.type == 'TEXT' || step.type == 'text') {
      return Assets.icons.learning.text.svg(
        colorFilter: ColorFilter.mode(
          isCompleted
              ? completed
              : isActive
              ? activeColor
              : inactiveColor,
          BlendMode.srcIn,
        ),
      );
    } else if (step.type == 'VIDEO' || step.type == 'video') {
      return Assets.icons.learning.currentVideoIcon.svg(
        colorFilter: ColorFilter.mode(
          isCompleted
              ? completed
              : isActive
              ? activeColor
              : inactiveColor,
          BlendMode.srcIn,
        ),
      );
    } else if (step.type == 'QUIZ' || step.type == 'quiz') {
      return Assets.icons.learning.questionMarkIcon.svg(
        colorFilter: ColorFilter.mode(
          isCompleted
              ? completed
              : isActive
              ? activeColor
              : inactiveColor,
          BlendMode.srcIn,
        ),
      );
    } else if (step.type == 'DOCUMENT' || step.type == 'text') {
      return Assets.icons.learning.currentVideoIcon.svg(
        colorFilter: ColorFilter.mode(
          isCompleted
              ? completed
              : isActive
              ? activeColor
              : inactiveColor,
          BlendMode.srcIn,
        ),
      );
    } else {
      return Assets.icons.learning.questionMarkIcon.svg(
        colorFilter: ColorFilter.mode(
          isCompleted
              ? completed
              : isActive
              ? activeColor
              : inactiveColor,
          BlendMode.srcIn,
        ),
      );
    }
  }

  Widget _customTab(
    Widget widget,
    BuildContext context, {
    required bool isSelected,
    required bool isCompleted,
  }) {
    final Color borderColor = isCompleted
        ? context.colors.neutralMuted
        : context.colors.accentMuted;

    return Container(
      height: 32.h,
      width: 48.w,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: isSelected
            ? context.colors.accentContainerDefault.withOpacity(0.1)
            : context.colors.containerDefault.withOpacity(0.1),
        border: isSelected ? Border.all(width: 2.w, color: borderColor) : null,
        borderRadius: BorderRadius.circular(50.r),
      ),
      child: widget,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 48.h);
}
