import 'package:leti_mobile/widget_imports.dart';

AppBar learningPageEmptyAppBar(BuildContext context) {
  return AppBar(
    elevation: 0,
    titleSpacing: 0,
    automaticallyImplyLeading: false,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
          icon: Assets.icons.main.arrowBack.svg(
            colorFilter: ColorFilter.mode(
              context.colors.fgDefault,
              BlendMode.srcIn,
            ),
          ),
        ),
      ],
    ),
  );
}
