import 'package:leti_mobile/widget_imports.dart';

class RecommendedCourses extends StatefulWidget {
  final String? headline;
  final String? coursesCount;
  final VoidCallback onTapViewAll;
  final List<double>? price;
  final String? learners;
  final double? rating;
  final int? courseDuration;
  final List<CertificateByTopicIdModel?>? isCertificateAvailble;
  final BlocProgress singleCourseBlocProgress;
  final List<CourseShortInfo> courses;
  final int? selectedCourseIndex;

  const RecommendedCourses({
    super.key,
    this.headline,
    this.coursesCount,
    this.price = const [],
    required this.onTapViewAll,
    this.learners = '0',
    this.rating = 0,
    this.courseDuration = 0,
    this.isCertificateAvailble,
    required this.singleCourseBlocProgress,
    required this.courses,
    this.selectedCourseIndex,
  });

  @override
  // ignore: library_private_types_in_public_api
  _RecommendedCoursesState createState() => _RecommendedCoursesState();
}

class _RecommendedCoursesState extends State<RecommendedCourses> {
  final ScrollController _scrollController = ScrollController();
  double _leftPadding = 16.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updatePadding);
  }

  void _updatePadding() {
    if (_scrollController.offset > 0) {
      setState(() {
        _leftPadding = 0.0;
      });
    } else {
      setState(() {
        _leftPadding = 16.0;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updatePadding);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Header(context),
        space16,
        SizedBox(
          height: 276.h,
          child: ListView.builder(
            controller: _scrollController,
            padding: EdgeInsets.only(left: _leftPadding),
            shrinkWrap: true,
            itemCount: widget.courses.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final singleCourseItem = widget.courses[index];
              final isSelected = singleCourseItem.id;

              return GestureDetector(
                onTap: () async {
                  final bool? result = await context
                      .read<CoursesBloc>()
                      .checkEnrollment(singleCourseItem.id);

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
                },

                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: EdgeInsets.only(right: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      singleCourseItem.id == isSelected &&
                              widget.singleCourseBlocProgress ==
                                  BlocProgress.IS_LOADING
                          ? Container(
                              height: 120.h,
                              width: 188.w,

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
                                    singleCourseItem.thumbnail?.original_url ??
                                    '',
                                height: 120.h,
                                width: 188.w,
                                fit: BoxFit.fill,
                                placeholder: (context, url) => Container(
                                  height: 120.h,
                                  width: 188.w,
                                  color: Colors.grey[200],
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                                errorWidget: (context, url, error) => Container(
                                  height: 120.h,
                                  width: 188.w,
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
                      SizedBox(
                        height: 156.h,
                        width: 188.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            space16,
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
                            Text(
                              singleCourseItem.short_description,

                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: context.colors.fgSoft,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            space8,
                            CourseInfo(
                              widget.learners ?? '',
                              widget.rating ?? 0,
                              widget.courseDuration ?? 0,
                              context,
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
                                : space20,
                            Text(
                              // index != 0 && index != 1
                              //     ? '${widget.price?[index]} UZS'
                              //     :
                              '200.000 UZS',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
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
                widget.headline ?? context.localizations.recommendedForYou,
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

Row CourseInfo(
  String learners,
  double rating,
  int courseDuration,
  BuildContext context, {
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
        rating.toString(),
        style: TextStyle(fontSize: 10.sp, color: context.colors.fgMuted),
      ),
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
  );
}
