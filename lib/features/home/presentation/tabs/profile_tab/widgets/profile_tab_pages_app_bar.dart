import 'package:leti_mobile/widget_imports.dart';

AppBar profileTabPagesAppBar(BuildContext context, String text) {
  return AppBar(
    automaticallyImplyLeading: false,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomAppBarBackButton(),
        SizedBox(width: 8.w),
        Text(
          text,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
        ),
      ],
    ),
  );
}
