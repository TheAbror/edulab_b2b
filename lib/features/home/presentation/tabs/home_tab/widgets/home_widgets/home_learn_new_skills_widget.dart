import 'package:leti_mobile/widget_imports.dart';

class HomeLearnNewSkillsWidget extends StatelessWidget {
  final VoidCallback onTap;

  const HomeLearnNewSkillsWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      margin: EdgeInsets.only(bottom: 10.h, left: 16.w, right: 16.w),
      decoration: BoxDecoration(
        color: context.colors.accentContainerSoft.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          SizedBox(height: 4.h),
          Text(
            context.localizations.learnNewSkills,
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w500,
              letterSpacing: -1,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            context.localizations.proveYourPotential,
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w500,
              letterSpacing: -1,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          ActionButton(
            text: context.localizations.viewAllCourses,
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}
