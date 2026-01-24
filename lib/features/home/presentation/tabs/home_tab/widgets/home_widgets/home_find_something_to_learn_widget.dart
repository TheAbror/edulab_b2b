import 'package:leti_mobile/widget_imports.dart';

class HomeFindSomethingToLearnWidget extends StatelessWidget {
  final VoidCallback onTap;

  const HomeFindSomethingToLearnWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: context.colors.accentContainerDefault.withOpacity(0.1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppText.title1(
            context.localizations.learnWithLeti,
            maxLines: 2,
          ),
          space6,
          AppText.paragraph2(
            context.localizations.exploreHighQuality,
            maxLines: 3,
          ),
          space20,
          GestureDetector(
            onTap: onTap,
            behavior: HitTestBehavior.opaque,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 13.h),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.all(Radius.circular(6.r)),
              ),
              child: Center(
                child: AppText.headline1(
                  context.localizations.joinForFree,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
