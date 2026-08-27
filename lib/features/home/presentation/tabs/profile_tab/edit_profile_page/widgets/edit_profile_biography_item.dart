import 'package:edulab_b2b/widget_imports.dart';

class EditProfileBiography extends StatelessWidget {
  final TextEditingController controller;

  const EditProfileBiography({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 96.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: EditProfileBoxDecoration(context),
      child: TextField(
        controller: controller,
        maxLines: null,
        expands: true,
        textAlignVertical: TextAlignVertical.top,
        style: TextStyle(
          fontSize: 15.sp,
          fontWeight: FontWeight.w400,
          color: context.colors.fgDefault,
        ),
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.zero,
          hintText: context.localizations.aboutMe,
          hintStyle: TextStyle(color: context.colors.fgSoft),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
      ),
    );
  }
}

BoxDecoration EditProfileBoxDecoration(BuildContext context) {
  return BoxDecoration(
    color: Theme.of(context).colorScheme.background,
    borderRadius: BorderRadius.circular(6.r),
    border: Border.all(
      color: context.colors.borderMuted.withOpacity(0.15),
      width: 1.w,
    ),
  );
}
