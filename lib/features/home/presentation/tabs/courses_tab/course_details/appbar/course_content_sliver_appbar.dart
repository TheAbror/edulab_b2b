import 'package:leti_mobile/widget_imports.dart';

class CourseContentSliverAppBar extends StatelessWidget {
  final SingleCourseInfo course;

  const CourseContentSliverAppBar({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return SliverAppBar(
          expandedHeight: 312.h,
          pinned: true,
          stretch: true,
          floating: false,
          automaticallyImplyLeading: false,
          flexibleSpace: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final double percentage =
                  (constraints.maxHeight - kToolbarHeight) /
                  (312.h - kToolbarHeight);
              final double opacity = percentage.clamp(0.0, 1.0);

              return GestureDetector(
                onTap: () =>
                    Navigator.pushNamed(context, AppRoutes.learningPage),
                child: Container(
                  color: state.isLightTheme
                      ? context.colors.status03ContainerDefault.withOpacity(0.1)
                      : Theme.of(context).colorScheme.background,
                  child: FlexibleSpaceBar(
                    centerTitle: true,
                    collapseMode: CollapseMode.parallax,
                    title: Opacity(
                      opacity: 1 - opacity,
                      child: Text(course.title, style: TextStyle()),
                    ),
                    background: Container(
                      color: state.isLightTheme
                          ? context.colors.status03ContainerDefault.withOpacity(
                              0.1,
                            )
                          : Color(0XFF9E8FF9).withOpacity(0.2),
                      padding: EdgeInsets.only(left: 16.w, right: 16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Spacer(),
                          Text(
                            course.title,
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w500,
                              letterSpacing: -1,
                            ),
                          ),
                          space16,
                          Text(
                            course.shortDescription,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Theme.of(context).colorScheme.surfaceTint,
                              letterSpacing: -0.5,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          space16,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                context.localizations.courseProgress,
                                style: TextStyle(
                                  color: context.colors.fgMuted,
                                  fontSize: 12.sp,
                                  letterSpacing: -0.5,
                                ),
                              ),
                              // if (course.progress != null)
                              //   Text(
                              //     '${course.progress ?? 0 / 100}%',
                              //     style: TextStyle(
                              //       color: context.colors.fgMuted,
                              //       fontSize: 12.sp,
                              //     ),
                              //   ),
                            ],
                          ),
                          space6,
                          // LinearProgressIndicator(
                          //   minHeight: 8.h,
                          //   value: (course.progress != null)
                          //       ? (course.progress ?? 0 / 100).toDouble()
                          //       : 0,
                          //   color: context.colors.successDefault,
                          //   backgroundColor: context.colors.float,
                          //   borderRadius: BorderRadius.circular(10.r),
                          // ),
                          SizedBox(height: 12.h),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(6.r),
                              ),
                              border: Border.all(
                                color: context.colors.accentMuted,
                                width: 2.w,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                context.localizations.continueButton,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                          ),
                          space16,
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
              icon: Assets.icons.main.arrowBack.svg(
                colorFilter: ColorFilter.mode(
                  context.colors.fgDefault,
                  BlendMode.srcIn,
                ),
              ),
            ),
            Spacer(),
            BlocBuilder<SingleCourseBloc, SingleCourseState>(
              builder: (context, state) {
                return GestureDetector(
                  onTap: () {
                    context.read<SingleCourseBloc>().postCourseAsFavorite(
                      course.id,
                    );
                  },
                  behavior: HitTestBehavior.opaque,
                  child: (state.isFavorite)
                      ? Assets.icons.courses.heartFilled.svg(
                          colorFilter: ColorFilter.mode(
                            Theme.of(context).colorScheme.primary,
                            BlendMode.srcIn,
                          ),
                        )
                      : Assets.icons.courses.heart.svg(
                          colorFilter: ColorFilter.mode(
                            context.colors.fgDefault,
                            BlendMode.srcIn,
                          ),
                        ),
                );
              },
            ),
            SizedBox(width: 16.w),
          ],
        );
      },
    );
  }
}

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        border: Border(
          bottom: BorderSide(
            width: 1.w,
            color: context.colors.borderMuted.withOpacity(0.15),
          ),
        ),
      ),
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
