import 'package:leti_mobile/widget_imports.dart';

class EditProfilePageItem extends StatelessWidget {
  final String label;
  final String text;
  final FocusNode textFieldFocusNode;

  const EditProfilePageItem({
    super.key,
    required this.label,
    required this.text,
    required this.textFieldFocusNode,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(textFieldFocusNode);
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.w),
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: EditProfileBoxDecoration(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Theme.of(context).colorScheme.surfaceTint,
              ),
            ),
            TextField(
              controller: TextEditingController(text: text),
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
      ),
    );
  }
}
