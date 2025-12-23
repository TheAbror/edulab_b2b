import 'package:leti_mobile/widget_imports.dart';

class LearningBottomNavigation extends StatelessWidget {
  const LearningBottomNavigation({
    super.key,
    required this.controller,
    required this.stepsLength,
    required this.status,
    required this.stepModel,
  });

  final TabController controller;
  final int stepsLength;
  final String status;
  final StepModel stepModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        bottom: Platform.isAndroid ? 50.h : 40.h,
      ),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: context.colors.borderMuted.withOpacity(0.15)),
        ),
      ),
      height: 90.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // PREV
          LearningBottomNavButtonLeft(
            onTap: () {
              final index = controller.index - 1;

              ///move to previous step
              if (controller.index > 0) {
                controller.animateTo(index);
                context.read<LearningBloc>().changeAppbarTabIndex(
                  index,
                  stepModel,
                );
              }

              ///move to previous topic
              if (controller.index == 0) {
                context.read<LearningBloc>().moveToPreviousTopic(
                  controller,
                  stepModel,
                );
              }
            },
            isEnabled: true,
            text: 'Prev',
          ),

          // NEXT
          LearningBottomNavButtonRight(
            onTap: () {
              final index = controller.index + 1;

              if (controller.index < stepsLength - 1) {
                controller.animateTo(index);
                context.read<LearningBloc>().changeAppbarTabIndex(
                  index,
                  stepModel,
                );
              }

              if (controller.index <= stepsLength - 1) {
                if (stepsLength == index) {
                  context.read<LearningBloc>().moveToNextTopic(stepModel);
                  controller.index = 0;
                }
              }
            },
            isEnabled: status == "COMPLETED" ? true : false,

            text: 'Next',
          ),
        ],
      ),
    );
  }
}
