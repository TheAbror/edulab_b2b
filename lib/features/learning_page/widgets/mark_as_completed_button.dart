import 'package:leti_mobile/widget_imports.dart';

class MarkAsCompleteButton extends StatelessWidget {
  const MarkAsCompleteButton({
    super.key,
    required this.markAsComplete,
    required this.status,
    this.canComplete = true,
  });

  final VoidCallback markAsComplete;
  final StepItemStatus status;
  final bool? canComplete;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: markAsComplete,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        height: 50.h,
        margin: EdgeInsets.only(top: 24.h),
        decoration: BoxDecoration(
          color: status == StepItemStatus.completed && (canComplete == true)
              ? context.colors.successDefault
              : Colors.grey,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (status == StepItemStatus.completed)
              Icon(
                Icons.done,
                color: CustomThemes.neutral0,
              ),
            if (status == StepItemStatus.completed && (canComplete == true))
              SizedBox(width: 10.w),
            AppText.headline1(
              status == StepItemStatus.completed && (canComplete == true)
                  ? context.localizations.completed
                  : context.localizations.markAsComplete,
              color: CustomThemes.neutral0,
            ),
          ],
        ),
      ),
    );
  }
}
