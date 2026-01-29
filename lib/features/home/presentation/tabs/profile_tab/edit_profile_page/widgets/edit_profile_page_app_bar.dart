import 'package:leti_mobile/widget_imports.dart';

AppBar EditProfilePageAppBar(BuildContext context) {
  return AppBar(
    elevation: 0.0,
    automaticallyImplyLeading: false,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomAppBarBackButton(),
        SizedBox(
          width: 256.w,
          child: Text(
            context.localizations.editProfile,
            style: TextStyle(fontSize: 16.sp),
          ),
        ),
        Assets.icons.courses.moreIcon.svg(),
      ],
    ),
  );
}
