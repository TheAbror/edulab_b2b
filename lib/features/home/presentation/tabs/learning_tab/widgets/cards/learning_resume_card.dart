import 'package:leti_mobile/widget_imports.dart';

class LearningResumeCard extends StatelessWidget {
  final String title;
  final String photo;
  final double progress;
  final String buttonText;
  final bool? isFirst;
  final VoidCallback onPressed;

  const LearningResumeCard({
    super.key,
    required this.title,
    required this.photo,
    required this.progress,
    this.isFirst = false,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.all(12.w),
          margin: EdgeInsets.only(bottom: 12.h),
          decoration: isFirst != null && isFirst == true
              ? state.isLightTheme == true
                    ? _isFirst(context, state)
                    : _isFirstDark(context, state)
              : _Ordinary(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4.r),
                    child: CachedNetworkImage(
                      imageUrl: photo,
                      height: 40.h,
                      width: 46.w,
                      fit: BoxFit.fill,
                      placeholder: (context, url) => Container(
                        height: 40.h,
                        width: 46.w,
                        color: Colors.grey[200],
                        child: Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) => Container(
                        height: 40.h,
                        width: 46.w,
                        decoration: BoxDecoration(
                          color: context.colors.neutralContainerDefault
                              .withOpacity(0.1),
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/images/network_image_error_case.png',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  SizedBox(
                    width: 231.w,
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.7,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    progress == 100.0
                        ? 'Completed'
                        : context.localizations.courseProgress,
                    style: TextStyle(
                      color: context.colors.fgMuted,
                      fontSize: 12.sp,
                      letterSpacing: -0.5,
                    ),
                  ),
                  Text(
                    '$progress%'.replaceAll('.0', ''),
                    style: TextStyle(
                      color: context.colors.fgMuted,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6.h),
              LinearProgressIndicator(
                minHeight: 8.h,
                value: progress / 100,
                color: progress == 100.0
                    ? Colors.green
                    : Theme.of(context).colorScheme.primary,
                backgroundColor: isFirst != null && isFirst == true
                    ? context.colors.float
                    : context.colors.bgSurface3,
                borderRadius: BorderRadius.circular(10.r),
              ),
              SizedBox(height: 12.h),
              GestureDetector(
                onTap: onPressed,
                behavior: HitTestBehavior.opaque,
                child: state.isLightTheme == true
                    ? _ContinueButton(context)
                    : isFirst != null && isFirst == true
                    ? _isFirstContinueButton(context)
                    : _ContinueButton(context),
              ),
            ],
          ),
        );
      },
    );
  }

  Container _ContinueButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.all(Radius.circular(6.r)),
        border: Border.all(color: context.colors.accentMuted, width: 2.w),
      ),
      child: Center(
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 15.sp,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }

  Container _isFirstContinueButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(6.r)),
        border: Border.all(color: context.colors.accentMuted, width: 2.w),
        gradient: LinearGradient(
          colors: const [Color(0XFF3E0868), Color(0XFF6C2400)],
        ),
      ),
      child: Center(
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 15.sp,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }

  BoxDecoration _isFirst(BuildContext context, HomeState state) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular((defaultRadius * 2).r),
      gradient: LinearGradient(
        colors: [
          context.colors.gradientContainer01Start,
          context.colors.gradientContainer01End,
        ],
      ),
    );
  }

  BoxDecoration _isFirstDark(BuildContext context, HomeState state) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular((defaultRadius * 2).r),
      gradient: LinearGradient(
        colors: const [Color(0XFF3E0868), Color(0XFF6C2400)],
      ),
    );
  }

  BoxDecoration _Ordinary(BuildContext context) {
    return BoxDecoration(
      color: Theme.of(context).colorScheme.background,
      borderRadius: BorderRadius.circular((defaultRadius * 2).r),
      border: Border.all(
        width: 1.w,
        color: context.colors.borderMuted.withOpacity(0.15),
      ),
    );
  }
}
