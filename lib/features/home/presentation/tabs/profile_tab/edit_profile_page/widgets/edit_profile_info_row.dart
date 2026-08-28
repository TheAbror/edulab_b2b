import 'package:edulab_b2b/widget_imports.dart';

/// Read-only label + value row for the "USER INFO" card on the edit profile
/// screen. Shows backend data that can't be edited here yet (there is no
/// profile-update endpoint).
class EditProfileInfoRow extends StatelessWidget {
  final String label;
  final String value;

  const EditProfileInfoRow({
    super.key,
    required this.label,
    required this.value,
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
          SizedBox(height: 2.h),
          Text(
            value,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: context.colors.fgDefault,
            ),
          ),
        ],
      ),
    );
  }
}
