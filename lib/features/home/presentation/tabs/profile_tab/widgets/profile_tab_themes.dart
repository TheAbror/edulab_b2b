import 'package:leti_mobile/widget_imports.dart';

Future<dynamic> themeSelectionDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 328.w,
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.localizations.theme,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: context.colors.fgDefault,
                      ),
                    ),
                    space20,
                    _themeItem(
                      context.localizations.light,
                      state.isLightTheme,
                      () => context.read<HomeBloc>().setTheme(true),
                      context,
                    ),
                    space20,
                    _themeItem(
                      context.localizations.dark,
                      !state.isLightTheme,
                      () => context.read<HomeBloc>().setTheme(false),
                      context,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      );
    },
  );
}

Widget _themeItem(
  String text,
  bool isSelected,
  VoidCallback onTap,
  BuildContext context,
) {
  return GestureDetector(
    onTap: onTap,
    behavior: HitTestBehavior.opaque,
    child: Row(
      children: [
        isSelected
            ? Container(
                height: 24.w,
                width: 24.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.r),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 8.w,
                  ),
                ),
              )
            : Container(
                height: 24.w,
                width: 24.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.r),
                  border: Border.all(
                    color: context.colors.borderMuted.withOpacity(0.15),
                    width: 2.w,
                  ),
                ),
              ),
        SizedBox(width: 8.w),
        Text(
          text,
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
