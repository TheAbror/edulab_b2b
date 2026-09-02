import 'package:edulab_b2b/widget_imports.dart';

/// First card on the course page: thumbnail + title, short description,
/// course-type badge, instructor mini-list and the enroll / preview actions.
class CourseInfoHeader extends StatelessWidget {
  final int id;

  const CourseInfoHeader({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SingleCourseBloc, SingleCourseState>(
      builder: (context, state) {
        final course = state.singleCourse;
        final instructors = <Authors>[
          ...course.authors,
          ...course.co_authors,
        ];
        final typeLabel = course.type?.label ?? '';
        final previewUrl = course.previewVideo?.originalUrl ?? '';

        return CourseSectionCard(
          innerPadding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: context.colors.borderMuted.withOpacity(0.15),
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    _Thumbnail(url: course.thumbnail?.originalUrl ?? ''),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        course.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 17.sp,
                          height: 22 / 17,
                          fontWeight: FontWeight.w500,
                          letterSpacing: -0.17,
                          color: context.colors.fgDefault,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (course.shortDescription.isNotEmpty ||
                        typeLabel.isNotEmpty) ...[
                      if (course.shortDescription.isNotEmpty)
                        Text(
                          course.shortDescription,
                          style: TextStyle(
                            fontSize: 14.sp,
                            height: 18 / 14,
                            color: context.colors.fgSoft,
                          ),
                        ),
                      if (typeLabel.isNotEmpty) ...[
                        SizedBox(height: 10.h),
                        CoursePillBadge(text: typeLabel),
                      ],
                      SizedBox(height: 24.h),
                    ],
                    if (instructors.isNotEmpty) ...[
                      Text(
                        context.localizations.instructors.toUpperCase(),
                        style: TextStyle(
                          fontSize: 10.sp,
                          height: 12 / 10,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.3,
                          color: context.colors.fgMuted,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      for (var i = 0; i < instructors.length; i++) ...[
                        if (i != 0) SizedBox(height: 8.h),
                        _InstructorRow(author: instructors[i]),
                      ],
                      SizedBox(height: 24.h),
                    ],
                    _EnrollButton(id: id, isRequested: state.isRequested),
                    if (previewUrl.isNotEmpty) ...[
                      SizedBox(height: 6.h),
                      _PillButton(
                        text: context.localizations.playPreview,
                        filled: false,
                        onTap: () =>
                            showCoursePreviewSheet(context, previewUrl),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _Thumbnail extends StatelessWidget {
  final String url;

  const _Thumbnail({required this.url});

  @override
  Widget build(BuildContext context) {
    final placeholder = Container(
      color: context.colors.neutralContainerDefault.withOpacity(0.1),
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(6.r),
      child: SizedBox(
        width: 62.w,
        height: 48.h,
        child: url.isEmpty
            ? placeholder
            : CachedNetworkImage(
                imageUrl: url,
                fit: BoxFit.cover,
                placeholder: (context, _) => placeholder,
                errorWidget: (context, _, __) => placeholder,
              ),
      ),
    );
  }
}

class _InstructorRow extends StatelessWidget {
  final Authors author;

  const _InstructorRow({required this.author});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CourseCircleAvatar(
          imageUrl: author.avatar?.originalUrl ?? '',
          initials: authorInitials(author),
        ),
        SizedBox(width: 8.w),
        Flexible(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Flexible(
                child: AppText.headline2(
                  authorFullName(author),
                  color: context.colors.fgDefault,
                  maxLines: 1,
                ),
              ),
              if (author.jobPosition.isNotEmpty) ...[
                SizedBox(width: 8.w),
                Flexible(
                  child: AppText.caption1(
                    author.jobPosition,
                    color: context.colors.fgSoft,
                    maxLines: 1,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _EnrollButton extends StatelessWidget {
  final int id;
  final bool isRequested;

  const _EnrollButton({required this.id, required this.isRequested});

  @override
  Widget build(BuildContext context) {
    return _PillButton(
      text: isRequested
          ? context.localizations.requested
          : context.localizations.enrollToThisCourse,
      filled: true,
      isDisabled: isRequested,
      onTap: () {
        final bool? isAuthorized = PreferencesServices.getAuthStatus();

        if (isAuthorized != true) {
          context.read<HomeBloc>().changeTabIndex(0);
          Navigator.pushNamed(context, AppRoutes.loginPage);
          return;
        }

        if (isRequested) return;

        context.read<CoursesBloc>().enrollToCourse(
          id,
          (CourseEnrollmentResponse data) {
            if (data.managerStatus == 'NEW') {
              showMessage(
                context.localizations.yourRequestSuccessManagerWillContact,
                context,
              );
              context.read<SingleCourseBloc>().manageRequested(true);
            }

            if (data.managerStatus?.isEmpty == true ||
                data.managerStatus == 'ENROLLED') {
              Navigator.pushReplacementNamed(
                context,
                AppRoutes.enrolledCoursePage,
                arguments: id,
              );
              showMessage(context.localizations.success, context);
              context.read<LearningTabBloc>().getInProgress();
            }
          },
          (String error) {
            showMessage(error, context, isError: true);
          },
        );
      },
    );
  }
}

class _PillButton extends StatelessWidget {
  final String text;
  final bool filled;
  final bool isDisabled;
  final VoidCallback onTap;

  const _PillButton({
    required this.text,
    required this.filled,
    required this.onTap,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 48.h,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: filled
              ? (isDisabled
                    ? context.colors.accentDefault.withOpacity(0.5)
                    : context.colors.accentDefault)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(9999),
          border: filled ? null : Border.all(color: context.colors.accentMuted),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16.sp,
            height: 20 / 16,
            fontWeight: FontWeight.w500,
            letterSpacing: -0.16,
            color: filled
                ? context.colors.accentOnAccent
                : context.colors.accentOnContainer,
          ),
        ),
      ),
    );
  }
}
