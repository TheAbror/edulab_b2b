import 'package:edulab_b2b/widget_imports.dart';

AppBar CropAvatarPageAppBar(BuildContext context) {
  return AppBar(
    elevation: 0.0,
    backgroundColor: context.colors.bgPage3,
    automaticallyImplyLeading: false,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomAppBarBackButton(),
        SizedBox(
          width: 256.w,
          child: Text(
            context.localizations.edit,
            style: TextStyle(fontSize: 16.sp),
          ),
        ),
        SizedBox(),
      ],
    ),
  );
}
