import 'package:leti_mobile/widget_imports.dart';

class CourseAllCategoiesBottomSheetTopIcons extends StatelessWidget {
  const CourseAllCategoiesBottomSheetTopIcons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12.h, right: 16.w, left: 16.w),
      child: Stack(
        children: [
          Center(child: Assets.icons.courses.bottomShettTopIcon.svg()),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              child: Text(
                context.localizations.filter,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
