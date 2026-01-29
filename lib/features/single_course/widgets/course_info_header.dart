import 'package:leti_mobile/widget_imports.dart';

class CourseInfoHeader extends StatelessWidget {
  final int id;
  const CourseInfoHeader({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    // final enrollmentStatus = context.read<CoursesBloc>().state.enrollmentStatus;

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
                  Text(
                    item.title,
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -1.5,
                    ),
                  ),
                  space16,
                  Text(
                    item.shortDescription,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      height: 1.3,
                      color: Theme.of(context).colorScheme.surfaceTint,
                    ),
                  ),
                  if (item.authors.isNotEmpty) ...[
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
                          image: authorItem.avatar?.original_url ?? '',
                          name:
                              '${authorItem.firstname} ${authorItem.lastname}',
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
                      if (!state.isRequested) {
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
