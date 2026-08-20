import 'package:edulab_b2b/widget_imports.dart';

class EditProfileBiography extends StatelessWidget {
  final FocusNode textFieldFocusNode;

  const EditProfileBiography({super.key, required this.textFieldFocusNode});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Request focus for the TextField when the container is tapped
        FocusScope.of(context).requestFocus(textFieldFocusNode);
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 96.h,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.w),
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: EditProfileBoxDecoration(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            TextField(
              // controller: TextEditingController(text: 'Biography'),
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.zero,
                hintText: 'Biography',
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ],
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
      width: 2.w,
    ),
  );
}
