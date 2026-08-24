import 'package:edulab_b2b/widget_imports.dart';

class LanguageSelectionPage extends StatelessWidget {
  const LanguageSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.bgPage2,
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: BlocBuilder<LocalizationBloc, LocalizationState>(
            builder: (context, state) {
              final languageName = returnLanguageName(
                state.languageCode ?? 'ru',
              );

              return Center(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 20.h,
                  ),
                  decoration: BoxDecoration(
                    color: context.colors.float,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        context.localizations.chooseLanguage,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w500,
                          color: context.colors.fgDefault,
                        ),
                      ),
                      SizedBox(height: 24.h),
                      languageItem(
                        'O’zbek',
                        languageName == 'O’zbek',
                        () =>
                            context.read<LocalizationBloc>().changeLocalization(
                              'uz',
                            ),
                        context,
                        Assets.icons.languageIcons.uz.svg(),
                      ),
                      SizedBox(height: 6.h),
                      languageItem(
                        'Русский',
                        languageName == 'Русский',
                        () =>
                            context.read<LocalizationBloc>().changeLocalization(
                              'ru',
                            ),
                        context,
                        Assets.icons.languageIcons.ru.svg(),
                      ),
                      SizedBox(height: 6.h),
                      languageItem(
                        'English',
                        languageName == 'English',
                        () =>
                            context.read<LocalizationBloc>().changeLocalization(
                              'en',
                            ),
                        context,
                        Assets.icons.languageIcons.en.svg(),
                      ),
                      SizedBox(height: 24.h),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(
                          context,
                          AppRoutes.loginPage,
                        ),
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          height: 48.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(999.r),
                          ),
                          child: Text(
                            context.localizations.continueButton,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.16,
                              color: context.colors.float,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

Widget languageItem(
  String text,
  bool isSelected,
  VoidCallback onTap,
  BuildContext context,
  Widget languageIcon,
) {
  final primary = Theme.of(context).colorScheme.primary;

  return GestureDetector(
    onTap: onTap,
    behavior: HitTestBehavior.opaque,
    child: Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: isSelected ? primary.withOpacity(0.05) : Colors.transparent,
        border: Border.all(
          color: isSelected
              ? primary
              : context.colors.borderMuted.withOpacity(0.15),
          width: 1.w,
        ),
        borderRadius: BorderRadius.circular(999.r),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: SizedBox(height: 20.w, width: 20.w, child: languageIcon),
          ),
          SizedBox(width: 10.w),
          Text(
            text,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: context.colors.fgDefault,
            ),
          ),
          Spacer(),
          Container(
            height: 24.w,
            width: 24.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? primary : Colors.transparent,
              border: isSelected
                  ? null
                  : Border.all(
                      color: context.colors.borderSoft.withOpacity(0.25),
                      width: 1.w,
                    ),
            ),
            child: isSelected
                ? Container(
                    height: 8.w,
                    width: 8.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.colors.float,
                    ),
                  )
                : null,
          ),
        ],
      ),
    ),
  );
}
