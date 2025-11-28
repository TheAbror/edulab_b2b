import 'package:leti_mobile/widget_imports.dart';

class HomeMyStudyWidget extends StatelessWidget {
  final String title;
  final int progress;
  final String buttonText;
  final String image;
  final VoidCallback viewAllOnTap;
  final VoidCallback continueCourse;

  const HomeMyStudyWidget({
    super.key,
    required this.title,
    required this.progress,
    required this.buttonText,
    required this.image,
    required this.viewAllOnTap,
    required this.continueCourse,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colors.accentContainerDefault.withOpacity(0.1),
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.localizations.myStudy,
                style: TextStyle(
                  fontSize: 16.sp,
                  letterSpacing: -1,
                  fontWeight: FontWeight.w500,
                ),
              ),
              GestureDetector(
                onTap: viewAllOnTap,
                behavior: HitTestBehavior.opaque,
                child: Text(
                  context.localizations.viewAll,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          space16,
          HomeCourseResumeCard(
            title: title,
            progress: progress,
            buttonText: buttonText,
            onPressed: continueCourse,
            image: image,
          ),
        ],
      ),
    );
  }
}
