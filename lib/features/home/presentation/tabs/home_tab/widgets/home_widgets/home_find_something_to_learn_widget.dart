import 'package:leti_mobile/widget_imports.dart';

class HomeFindSomethingToLearnWidget extends StatelessWidget {
  final VoidCallback onTap;

  const HomeFindSomethingToLearnWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      margin: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: context.colors.accentContainerDefault.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Assets.icons.homeTabIcons.notificationBell.image(height: 56.h),
          space20,
          Text(
            context.localizations.itLooksLikeUJNotEnroller,
            style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          space20,
          GestureDetector(
            onTap: onTap,
            behavior: HitTestBehavior.opaque,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.all(Radius.circular(6.r)),
              ),
              child: Center(
                child: Text(
                  context.localizations.findsomethingToLearn,
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: context.colors.float,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
