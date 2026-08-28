import 'package:edulab_b2b/widget_imports.dart';

class CourseListCard extends StatefulWidget {
  final List<CourseShortInfo> courses;

  const CourseListCard({super.key, required this.courses});

  @override
  State<CourseListCard> createState() => _CourseListCardState();
}

class _CourseListCardState extends State<CourseListCard> {
  int? selectedCourseId;
  bool isLoadingSelected = false;
  final bool? isAuthorized = PreferencesServices.getAuthStatus();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: context.colors.bgSurface1,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: List.generate(
          widget.courses.length,
          (index) {
            final course = widget.courses[index];
            final isLast = index == widget.courses.length - 1;

            return GestureDetector(
              onTap: () => _onTap(context, course),
              behavior: HitTestBehavior.opaque,
              child: Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  border: isLast
                      ? null
                      : Border(
                          bottom: BorderSide(
                            color: context.colors.borderMuted.withOpacity(0.15),
                          ),
                        ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText.headline2(
                            course.title,
                            maxLines: 2,
                            color: context.colors.fgDefault,
                          ),
                          SizedBox(height: 10.h),
                          AppText.caption1(
                            course.short_description,
                            maxLines: 2,
                            color: context.colors.fgSoft,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16.w),
                    _buildThumbnail(
                      context,
                      course,
                      isSelected: selectedCourseId == course.id,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildThumbnail(
    BuildContext context,
    CourseShortInfo course, {
    required bool isSelected,
  }) {
    if (isSelected && isLoadingSelected) {
      return Container(
        height: 60.h,
        width: 80.w,
        decoration: BoxDecoration(
          color: context.colors.neutralContainerDefault.withOpacity(0.1),
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: const Center(
          child: SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(4.r),
      child: CachedNetworkImage(
        imageUrl: course.thumbnail?.originalUrl ?? '',
        height: 60.h,
        width: 80.w,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          height: 60.h,
          width: 80.w,
          color: Colors.grey[200],
        ),
        errorWidget: (context, url, error) => Container(
          height: 60.h,
          width: 80.w,
          color: context.colors.neutralContainerDefault.withOpacity(0.1),
        ),
      ),
    );
  }

  Future<void> _onTap(BuildContext context, CourseShortInfo course) async {
    if (isAuthorized != true) {
      Navigator.pushNamed(
        context,
        AppRoutes.singleCoursePage,
        arguments: course.id,
      );
      return;
    }

    setState(() {
      selectedCourseId = course.id;
      isLoadingSelected = true;
    });

    final bool? result = await context.read<CoursesBloc>().checkEnrollment(
      course.id,
    );
    setState(() => isLoadingSelected = false);

    if (!context.mounted) return;
    if (result != null) {
      Navigator.pushNamed(
        context,
        result ? AppRoutes.enrolledCoursePage : AppRoutes.singleCoursePage,
        arguments: course.id,
      );
    }
  }
}
