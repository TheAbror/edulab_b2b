import 'package:edulab_b2b/widget_imports.dart';

Future<dynamic> languageSelectionDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return BlocBuilder<LocalizationBloc, LocalizationState>(
        builder: (context, state) {
          final languageName = returnLanguageName(state.languageCode ?? 'ru');

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
                      'Language',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    space20,
                    themeItem(
                      'O’zbek',
                      languageName == 'O’zbek' ? true : false,
                      () => context.read<LocalizationBloc>().changeLocalization(
                        'uz',
                      ),
                      context,
                      Assets.icons.languageIcons.uz.svg(),
                    ),
                    space20,
                    themeItem(
                      'English',
                      languageName == 'English' ? true : false,
                      () => context.read<LocalizationBloc>().changeLocalization(
                        'en',
                      ),
                      context,
                      Assets.icons.languageIcons.en.svg(),
                    ),
                    space20,
                    themeItem(
                      'Русский',
                      languageName == 'Русский' ? true : false,
                      () => context.read<LocalizationBloc>().changeLocalization(
                        'ru',
                      ),
                      context,
                      Assets.icons.languageIcons.ru.svg(),
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

Widget themeItem(
  String text,
  bool isSelected,
  VoidCallback onTap,
  BuildContext context,
  Widget languageIcon,
) {
  return GestureDetector(
    onTap: onTap,
    behavior: HitTestBehavior.opaque,
    child: Row(
      children: [
        languageIcon,
        SizedBox(width: 8.w),
        Text(
          text,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
        ),
        Spacer(),
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
      ],
    ),
  );
}
