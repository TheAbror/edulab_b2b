import 'package:edulab_b2b/widget_imports.dart';

class OurCoursesWidget extends StatefulWidget {
  final String? headline;
  final List<CourseShortInfo> courses;
  final bool? isHeaderedNeeded;

  const OurCoursesWidget({
    super.key,
    this.headline,
    required this.courses,
    this.isHeaderedNeeded = true,
  });

  @override
  // ignore: library_private_types_in_public_api
  _OurCoursesWidgetState createState() => _OurCoursesWidgetState();
}

class _OurCoursesWidgetState extends State<OurCoursesWidget> {
  final ScrollController _scrollController = ScrollController();
  int? selectedCourseId;
  bool isLoadingSelected = false;
  final bool? isAuthorized = PreferencesServices.getAuthStatus();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 12.h),
        if (widget.isHeaderedNeeded == true) _Header(context),
        if (widget.isHeaderedNeeded == true) space10,

        GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.w,
            mainAxisSpacing: 8.h,
            mainAxisExtent: 234.h,
          ),
          controller: _scrollController,
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.courses.length < 4 ? widget.courses.length : 4,
          itemBuilder: (context, index) {
            final singleCourseItem = widget.courses[index];
            final isSelected = selectedCourseId == singleCourseItem.id;
            final author = singleCourseItem.authors.isNotEmpty
                ? singleCourseItem.authors.first
                : null;

            return GestureDetector(
              onTap: () => _onTap(context, singleCourseItem),
              behavior: HitTestBehavior.opaque,
              child: Container(
                padding: EdgeInsets.only(
                  left: 10.w,
                  right: 10.w,
                  top: 10.h,
                  bottom: 16.h,
                ),
                decoration: BoxDecoration(
                  color: context.colors.bgSurface1,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildThumbnail(context, singleCourseItem, isSelected),
                    SizedBox(height: 8.h),
                    SizedBox(
                      height: 12.h,
                      child: Text(
                        singleCourseItem.category.title,
                        style: TextStyle(
                          fontSize: 10.sp,
                          height: 1.2,
                          color: context.colors.fgMuted,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    SizedBox(
                      height: 36.h,
                      child: Text(
                        singleCourseItem.title,
                        style: TextStyle(
                          fontSize: 14.sp,
                          height: 18 / 14,
                          fontWeight: FontWeight.w400,
                          color: context.colors.fgDefault,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    SizedBox(
                      height: 20.h,
                      child: author == null
                          ? const SizedBox.shrink()
                          : Row(
                              children: [
                                _buildAuthorAvatar(context, author),
                                SizedBox(width: 8.w),
                                Expanded(
                                  child: Text(
                                    '${author.firstname} ${author.lastname}'
                                        .trim(),
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: context.colors.fgDefault,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),

        if (widget.isHeaderedNeeded == true) ...[
          space10,
          _ShowAllButton(context),
        ],
      ],
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

  Widget _buildThumbnail(
    BuildContext context,
    CourseShortInfo course,
    bool isSelected,
  ) {
    if (isSelected && isLoadingSelected) {
      return Container(
        height: 120.h,
        decoration: BoxDecoration(
          color: context.colors.neutralContainerDefault.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(8.r),
      child: CachedNetworkImage(
        imageUrl: course.thumbnail?.originalUrl ?? '',
        height: 120.h,
        width: double.infinity,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          height: 120.h,
          color: Colors.grey[200],
          child: const Center(child: CircularProgressIndicator()),
        ),
        errorWidget: (context, url, error) => Container(
          height: 120.h,
          decoration: BoxDecoration(
            color: context.colors.neutralContainerDefault.withOpacity(0.1),
            image: const DecorationImage(
              image: AssetImage('assets/images/network_image_error_case.png'),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAuthorAvatar(BuildContext context, Authors author) {
    final initials =
        '${author.firstname.isNotEmpty ? author.firstname[0] : ''}${author.lastname.isNotEmpty ? author.lastname[0] : ''}'
            .toUpperCase();

    return ClipOval(
      child: Container(
        width: 16.w,
        height: 16.w,
        color: context.colors.neutralContainerDefault.withOpacity(0.1),
        child: CachedNetworkImage(
          imageUrl: author.avatar?.originalUrl ?? '',
          fit: BoxFit.cover,
          placeholder: (context, url) => const SizedBox.shrink(),
          errorWidget: (context, url, error) => Center(
            child: Text(
              initials,
              style: TextStyle(
                fontSize: 7.sp,
                color: context.colors.neutralOnContainer,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _Header(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            widget.headline ?? context.localizations.coursesTab,
            style: TextStyle(
              fontSize: 16.sp,
              letterSpacing: -0.16,
              fontWeight: FontWeight.w500,
              color: context.colors.fgDefault,
            ),
          ),
          GestureDetector(
            onTap: () => context.read<HomeBloc>().changeTabIndex(1),
            behavior: HitTestBehavior.opaque,
            child: Text(
              context.localizations.showAll,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: context.colors.accentDefault,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _ShowAllButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: GestureDetector(
        onTap: () => context.read<HomeBloc>().changeTabIndex(1),
        behavior: HitTestBehavior.opaque,
        child: Container(
          height: 48.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: context.colors.bgSurface1,
            borderRadius: BorderRadius.circular(999.r),
          ),
          child: Text(
            context.localizations.showAll,
            style: TextStyle(
              fontSize: 16.sp,
              letterSpacing: -0.16,
              fontWeight: FontWeight.w500,
              color: context.colors.accentOnContainer,
            ),
          ),
        ),
      ),
    );
  }
}
