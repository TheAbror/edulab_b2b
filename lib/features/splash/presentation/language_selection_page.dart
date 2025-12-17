import 'package:leti_mobile/widget_imports.dart';

class LanguageSelectionPage extends StatelessWidget {
  const LanguageSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        child: BlocBuilder<LocalizationBloc, LocalizationState>(
          builder: (context, state) {
            final languageName = returnLanguageName(state.languageCode ?? 'ru');

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                AppText.title1(context.localizations.chooseLanguage),
                space32,
                themeItem(
                  'O’zbek',
                  languageName == 'O’zbek' ? true : false,
                  () => context.read<LocalizationBloc>().changeLocalization(
                    'uz',
                  ),
                  context,
                  Assets.icons.languageIcons.uz.svg(),
                ),
                themeItem(
                  'English',
                  languageName == 'English' ? true : false,
                  () => context.read<LocalizationBloc>().changeLocalization(
                    'en',
                  ),
                  context,
                  Assets.icons.languageIcons.en.svg(),
                ),
                themeItem(
                  'Русский',
                  languageName == 'Русский' ? true : false,
                  () => context.read<LocalizationBloc>().changeLocalization(
                    'ru',
                  ),
                  context,
                  Assets.icons.languageIcons.ru.svg(),
                ),
                Spacer(),
                ActionButton(
                  text: context.localizations.next,
                  onTap: () =>
                      Navigator.pushNamed(context, AppRoutes.welcomePage),
                ),
                space20,
                space40,
              ],
            );
          },
        ),
      ),
    );
  }
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
    child: Container(
      padding: EdgeInsets.all(16.w),
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: _decoration(context, isSelected),
      child: Row(
        children: [
          languageIcon,
          SizedBox(width: 8.w),
          AppText.baseText(text),
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
    ),
  );
}

BoxDecoration _decoration(BuildContext context, bool isSelected) {
  return BoxDecoration(
    border: Border.all(
      width: 2.w,
      color: isSelected
          ? Theme.of(context).colorScheme.primary
          : context.colors.borderMuted.withOpacity(0.15),
    ),
    borderRadius: BorderRadius.circular(12.r),
  );
}
