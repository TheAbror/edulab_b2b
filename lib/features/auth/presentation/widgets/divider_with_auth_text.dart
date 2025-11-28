import 'package:leti_mobile/widget_imports.dart';

class DividerWithOrText extends StatelessWidget {
  const DividerWithOrText({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.h,
      margin: EdgeInsets.symmetric(vertical: 16.h),
      child: Row(
        children: [
          Expanded(
            child: Divider(color: context.colors.fgMuted, height: 1.h),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Text(
              context.localizations.or,
              style: TextStyle(color: context.colors.fgMuted),
            ),
          ),
          Expanded(
            child: Divider(color: context.colors.fgMuted, height: 1.h),
          ),
        ],
      ),
    );
  }
}
