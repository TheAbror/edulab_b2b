import 'package:flutter/cupertino.dart';
import 'package:leti_mobile/widget_imports.dart';

class FilterCourseBottomSheetSwitch extends StatelessWidget {
  final String title;
  final bool switchValue;
  final Function(bool) onSwitchChanged;

  const FilterCourseBottomSheetSwitch({
    super.key,
    required this.title,
    required this.switchValue,
    required this.onSwitchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              letterSpacing: -0.5,
            ),
          ),
          Platform.isAndroid
              ? Switch(
                  value: switchValue,
                  activeColor: Theme.of(context).colorScheme.primary,
                  onChanged: onSwitchChanged,
                )
              : CupertinoSwitch(
                  value: switchValue,
                  activeColor: Theme.of(context).colorScheme.primary,
                  onChanged: onSwitchChanged,
                ),
        ],
      ),
    );
  }
}
