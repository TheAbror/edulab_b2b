import 'package:leti_mobile/widget_imports.dart';

class CourseInfoHeader extends StatelessWidget {
  final int id;
  const CourseInfoHeader({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, homeState) {
        return Container(
          color: homeState.isLightTheme == true
              ? context.colors.status03ContainerDefault.withOpacity(0.1)
              : Color(0XFF9E8FF9).withOpacity(0.2),
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: BlocBuilder<SingleCourseBloc, SingleCourseState>(
            builder: (context, state) {
              final item = state.singleCourse;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  space20,
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: CachedNetworkImage(
                          imageUrl: item.thumbnail?.originalUrl ?? '',
                          height: 48.h,
                          width: 62.w,
                          fit: BoxFit.fill,
                          placeholder: (context, url) => Container(
                            height: 48.h,
                            color: Colors.grey[200],
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            height: 48.h,
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

                      SizedBox(width: 8.w),

                      Flexible(
                        child: Text(
                          item.title,
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -1.5,
                          ),
                        ),
                      ),
                    ],
                  ),

                  if (item.authors.isNotEmpty) ...[
                    space4,
                    space24,
                    Text(
                      context.localizations.authors.toUpperCase(),
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                        color: context.colors.fgMuted,
                      ),
                    ),
                    space8,
                    ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: item.authors.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final authorItem = item.authors[index];
                        return CourseAuthorsItem(
                          image: authorItem.avatar?.originalUrl ?? '',
                          name:
                              '${authorItem.lastname} ${authorItem.firstname}',
                          occupation: authorItem.jobPosition,
                        );
                      },
                    ),
                  ],
                  space24,
                  CourseInfoSmallHeadline(text: context.localizations.price),
                  AppText.title2(
                    item.price.isNotEmpty
                        ? item.price
                        : context.localizations.free,
                  ),

                  space12,

                  ActionButton(
                    text: state.isRequested
                        ? context.localizations.requested
                        : context.localizations.enrollToThisCourse,
                    isDisabled: state.isRequested,
                    onTap: () {
                      final bool? isAuthorized =
                          PreferencesServices.getAuthStatus();

                      if (isAuthorized != true) {
                        context.read<HomeBloc>().changeTabIndex(0);
                        Navigator.pushNamed(
                          context,
                          AppRoutes.loginPage,
                        );
                      }

                      if (!state.isRequested && isAuthorized == true) {
                        context.read<CoursesBloc>().enrollToCourse(
                          id,

                          (CourseEnrollmentResponse data) {
                            if (data.managerStatus == 'NEW') {
                              showMessage(
                                context
                                    .localizations
                                    .yourRequestSuccessManagerWillContact,
                                context,
                              );

                              context.read<SingleCourseBloc>().manageRequested(
                                true,
                              );
                            }

                            if (data.managerStatus?.isEmpty == true ||
                                data.managerStatus == 'ENROLLED') {
                              Navigator.pushReplacementNamed(
                                context,
                                AppRoutes.enrolledCoursePage,
                                arguments: id,
                              );

                              showMessage(
                                context.localizations.success,
                                context,
                              );

                              context.read<LearningTabBloc>().getInProgress();
                            }
                          },
                          (String error) {
                            showMessage(
                              isError: true,
                              error,
                              context,
                            );
                          },
                        );
                      }
                    },
                  ),
                  space12,
                ],
              );
            },
          ),
        );
      },
    );
  }
}
