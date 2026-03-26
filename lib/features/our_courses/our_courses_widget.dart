import 'package:leti_mobile/widget_imports.dart';

class OurCoursesWidget extends StatefulWidget {
  final String? headline;
  final String? coursesCount;
  final int? courseDuration;
  final List<CertificateByTopicIdModel?>? isCertificateAvailble;
  final List<CourseShortInfo> courses;
  final bool? isHeaderedNeeded;

  const OurCoursesWidget({
    super.key,
    this.headline,
    this.coursesCount,
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

  static const List<Map<String, dynamic>> _priceData = [
    {'original': '5 000 000 UZS'},
    {'original': '3 000 000 UZS'},
    {'original': ''},
    {'original': '1 500 000 UZS'},
  ];

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
            childAspectRatio: 175.w / 280.h,
          ),
          controller: _scrollController,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          shrinkWrap: true,
          itemCount: widget.courses.length,
          itemBuilder: (context, index) {
            final singleCourseItem = widget.courses[index];
            final isSelected = selectedCourseId == singleCourseItem.id;

            return GestureDetector(
              onTap: () => _onTap(context, singleCourseItem),
              behavior: HitTestBehavior.opaque,
              child: Container(
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
                    _buildThumbnail(context, singleCourseItem, isSelected),
                    SizedBox(height: 8.h),
                    Text(
                      singleCourseItem.title,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    SizedBox(height: 2.h),

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

                    if (singleCourseItem.showPrice == true) ...[
                      Spacer(),
                      Text(
                        _priceData[index].values.first,
                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          decorationStyle: TextDecorationStyle.solid,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w400,
                          color: context.colors.fgMuted,
                        ),
                      ),
                      AppText.footNote(
                        singleCourseItem.price?.isEmpty == true
                            ? context.localizations.free
                            : singleCourseItem.price ?? '',
                        color: context.colors.fgDefault,
                      ),
                    ],
                  ],
                ),
              ),
            );
          },
        ),
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
