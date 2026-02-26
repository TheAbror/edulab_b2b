import 'package:leti_mobile/widget_imports.dart';

class OurCoursesWidget extends StatefulWidget {
  final String? headline;
  final String? coursesCount;
  final VoidCallback onTapViewAll;
  final int? courseDuration;
  final List<CertificateByTopicIdModel?>? isCertificateAvailble;
  final List<CourseShortInfo> courses;
  final bool? isHeaderedNeeded;

  const OurCoursesWidget({
    super.key,
    this.headline,
    this.coursesCount,
    required this.onTapViewAll,
    this.courseDuration = 0,
    this.isCertificateAvailble,
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
        SizedBox(height: 10.h),
        if (widget.isHeaderedNeeded == true) _Header(context),
        if (widget.isHeaderedNeeded == true) space8,
        GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.w,
            mainAxisSpacing: 12.h,
            childAspectRatio: 155.w / 250.h,
          ),
          controller: _scrollController,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          shrinkWrap: true,
          itemCount: widget.courses.length,
          itemBuilder: (context, index) {
            final singleCourseItem = widget.courses[index];
            final isSelected = selectedCourseId == singleCourseItem.id;

            return GestureDetector(
              onTap: () async {
                if (isAuthorized == true) {
                  setState(() {
                    selectedCourseId = singleCourseItem.id;
                    isLoadingSelected = true;
                  });
                  final bool? result = await context
                      .read<CoursesBloc>()
                      .checkEnrollment(singleCourseItem.id);

                  setState(() => isLoadingSelected = false);

                  if (!context.mounted) return;

                  if (result != null) {
                    Navigator.pushNamed(
                      context,
                      result
                          ? AppRoutes.enrolledCoursePage
                          : AppRoutes.singleCoursePage,
                      arguments: singleCourseItem.id,
                    );
                  }
                } else {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.singleCoursePage,
                    arguments: singleCourseItem.id,
                  );
                }
              },

              behavior: HitTestBehavior.opaque,
              child: Container(
                height: 250.h,
                padding: EdgeInsets.only(
                  left: 10.w,
                  right: 10.w,
                  top: 10.h,
                  bottom: 8.h,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2.w,
                    color: context.colors.borderMuted.withOpacity(0.15),
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: isSelected && isLoadingSelected
                          ? Container(
                              height: 120.h,
                              decoration: BoxDecoration(
                                color: context.colors.neutralContainerDefault
                                    .withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Center(child: CircularProgressIndicator()),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(8.r),
                              child: CachedNetworkImage(
                                imageUrl:
                                    singleCourseItem.thumbnail?.originalUrl ??
                                    '',
                                height: 120.h,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Container(
                                  height: 120.h,
                                  color: Colors.grey[200],
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                                errorWidget: (context, url, error) => Container(
                                  height: 120.h,
                                  decoration: BoxDecoration(
                                    color: context
                                        .colors
                                        .neutralContainerDefault
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
                    ),
                    SizedBox(
                      height: 106.h,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          space8,
                          Text(
                            singleCourseItem.title,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          space8,

                          Spacer(),
                          CourseInfo(
                            learners: singleCourseItem.learnersCount.toString(),
                            rating: singleCourseItem.rating,
                            context: context,
                            isCertificateAvailble:
                                widget.isCertificateAvailble != null &&
                                    widget
                                            .isCertificateAvailble?[index]
                                            ?.title
                                            .isNotEmpty ==
                                        true
                                ? true
                                : false,
                          ),
                          singleCourseItem.short_description.length < 25
                              ? Spacer()
                              : space10,
                          AppText.footNote(
                            singleCourseItem.price?.isEmpty == true
                                ? context.localizations.free
                                : singleCourseItem.price ?? '',
                            color: context.colors.fgDefault,
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
      ],
    );
  }

  Widget _Header(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.headline ?? context.localizations.ourCourses,
                style: TextStyle(
                  fontSize: 17.sp,
                  letterSpacing: -1,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 4.h),
              widget.coursesCount != null &&
                      widget.coursesCount?.isNotEmpty == true
                  ? Text(
                      '${widget.coursesCount} courses ',
                      style: TextStyle(
                        fontSize: 12.sp,
                        letterSpacing: -1,
                        color: Theme.of(context).colorScheme.surfaceTint,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  : SizedBox(),
            ],
          ),
          GestureDetector(
            onTap: widget.onTapViewAll,
            behavior: HitTestBehavior.opaque,
            child: Text(
              context.localizations.viewAll,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.primary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

Row CourseInfo({
  required String learners,
  required String rating,
  int? courseDuration,
  required BuildContext context,
  bool? isCertificateAvailble,
}) {
  return Row(
    children: [
      Assets.icons.courses.user.svg(),
      SizedBox(width: 6.w),
      Text(
        learners,
        style: TextStyle(fontSize: 10.sp, color: context.colors.fgMuted),
      ),
      SizedBox(width: 10.w),
      Assets.icons.courses.star.svg(),
      SizedBox(width: 6.w),
      Text(
        rating,
        style: TextStyle(fontSize: 10.sp, color: context.colors.fgMuted),
      ),

      if (courseDuration != null) ...[
        SizedBox(width: 10.w),
        Assets.icons.courses.clock.svg(),
        SizedBox(width: 6.w),
        Text(
          '${courseDuration}H',
          style: TextStyle(fontSize: 10.sp, color: context.colors.fgMuted),
        ),
        SizedBox(width: 10.w),
        isCertificateAvailble == true
            ? Assets.icons.courses.courseCertificate.svg()
            : SizedBox.shrink(),
      ],
    ],
  );
}
