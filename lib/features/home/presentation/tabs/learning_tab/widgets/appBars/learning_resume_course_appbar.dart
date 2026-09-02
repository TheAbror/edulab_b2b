import 'package:edulab_b2b/widget_imports.dart';

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
          SizedBox(width: 20.w),
          Expanded(
            child: Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 17.sp,
                height: 22 / 17,
                fontWeight: FontWeight.w500,
                letterSpacing: -0.17,
                color: context.colors.fgDefault,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          GestureDetector(
            onTap: () => showChatBottomSheet(context),
            behavior: HitTestBehavior.opaque,
            child: Assets.icons.chat.chat.svg(
              width: 24.w,
              height: 24.w,
              colorFilter: ColorFilter.mode(
                context.colors.fgDefault,
                BlendMode.srcIn,
              ),
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
  }) {
    // 48x32 pill with a 24x24 icon, per the "course stepper" component. The
    // 2px border marks the step the learner is currently on.
    return Container(
      height: 32.h,
      width: 48.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: context.colors.neutralContainerDefault.withOpacity(0.1),
        border: isSelected
            ? Border.all(width: 2.w, color: context.colors.neutralMuted)
            : null,
        borderRadius: BorderRadius.circular(100.r),
      ),
      child: SizedBox(
        height: 24.w,
        width: 24.w,
        child: widget,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 48.h);
}
