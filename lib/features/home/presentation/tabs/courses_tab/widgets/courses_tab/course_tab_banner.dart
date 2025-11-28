import 'package:leti_mobile/widget_imports.dart';

class CourseTabBanner extends StatelessWidget {
  const CourseTabBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.all(16.w),
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: context.colors.status06ContainerDefault.withOpacity(
              state.isLightTheme ? 0.1 : 0.2,
            ),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            children: [
              Assets.icons.courses.handWithLoudspeakerMegaphoneWithLightnings1
                  .image(height: 120.h, width: 142.w),
              space16,
              Text(
                context.localizations.shopOurSale,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -1,
                ),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 8.h),
                child: Text(
                  context.localizations.weHaveGotLearning,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    letterSpacing: -1,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Text(
                '1 ${context.localizations.dayLeft}',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -1,
                ),
              ),
              space16,
              GestureDetector(
                onTap: () =>
                    Navigator.pushNamed(context, AppRoutes.allCoursesPage),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: context.colors.neutralDefault.withOpacity(
                      state.isLightTheme ? 0.1 : 0.2,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(6.r)),
                  ),
                  child: Center(
                    child: Text(
                      context.localizations.findsomethingToLearn,
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: context.colors.neutralOnContainer,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
