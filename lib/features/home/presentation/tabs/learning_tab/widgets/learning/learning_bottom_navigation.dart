import 'package:leti_mobile/widget_imports.dart';

class LearningBottomNavigation extends StatelessWidget {
  const LearningBottomNavigation({
    super.key,
    required this.controller,
    required this.stepsLength,
  });

  final TabController controller;
  final int stepsLength;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 20.h),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: context.colors.borderMuted.withOpacity(0.15)),
        ),
      ),
      height: 76.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // PREV
          LearningBottomNavButtonLeft(
            onTap: () {
              if (controller.index > 0) {
                controller.animateTo(controller.index - 1);
              }
            },
            text: 'Prev',
          ),

          // NEXT
          LearningBottomNavButtonRight(
            onTap: () {
              if (controller.index < stepsLength - 1) {
                controller.animateTo(controller.index + 1);
              }
            },
            text: 'Next',
          ),
        ],
      ),
    );
  }
}
