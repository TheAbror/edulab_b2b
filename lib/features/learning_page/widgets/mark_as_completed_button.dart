import 'package:leti_mobile/widget_imports.dart';

class MarkAsCompleteButton extends StatelessWidget {
  const MarkAsCompleteButton({
    super.key,
    required this.markAsComplete,
    required this.status,
    this.canComplete = true,
  });

  final VoidCallback markAsComplete;
  final String status;
  final bool? canComplete;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: markAsComplete,
      child: Container(
        height: 48.h,
        width: 163.w,
        margin: EdgeInsets.only(top: 24.h),
        decoration: BoxDecoration(
          color: status == "COMPLETED" && (canComplete == true)
              ? context.colors.successDefault
              : context.colors.accentDefault,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (status == "COMPLETED")
              Icon(
                Icons.done,

                color: CustomThemes.neutral0,
              ),
            if (status == "COMPLETED" && (canComplete == true))
              SizedBox(width: 10.w),
            AppText.headline1(
              status == "COMPLETED" && (canComplete == true)
                  ? "Completed"
                  : 'Mark as complete',
              color: CustomThemes.neutral0,
            ),
          ],
        ),
      ),
    );
  }
}
