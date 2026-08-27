import 'package:edulab_b2b/widget_imports.dart';

class EditProfilePageItem extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const EditProfilePageItem({
    super.key,
    required this.label,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: TextStyle(
              color: context.colors.fgMuted,
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.3,
            ),
          ),
          TextField(
            controller: controller,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: context.colors.fgDefault,
            ),
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.zero,
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }
}
