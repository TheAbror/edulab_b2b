import 'package:leti_mobile/widget_imports.dart';

class AllCoursesPage extends StatelessWidget {
  const AllCoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = CoursesBloc();

        bloc.getAllCourses();

        return bloc;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomAppBarBackButton(),
              SizedBox(width: 12.w),
              Text(
                context.localizations.allCourses,
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        body: _Body(),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoursesBloc, CoursesState>(
      builder: (context, state) {
        if (state.blocProgress == BlocProgress.IS_LOADING) {
          return const PrimaryLoader();
        }

        if (state.coursesAll.isEmpty) {
          return Center(
            child: AppText.headline2(
              context.localizations.noResults,
            ),
          );
        }

        return ListView(
          children: [
            Divider(
              color: context.colors.borderMuted.withOpacity(0.15),
              height: 1.h,
            ),
            ListView.separated(
              itemCount: state.coursesAll.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                final item = state.coursesAll[index];

                return AllCoursesItem(item: item);
              },
              separatorBuilder: (context, index) {
                return Divider(
                  color: context.colors.borderMuted.withOpacity(0.15),
                  height: 1.h,
                );
              },
            ),
            if (state.coursesAll.isNotEmpty)
              Divider(
                color: context.colors.borderMuted.withOpacity(0.15),
                height: 1.h,
              ),
          ],
        );
      },
    );
  }
}

class AllCoursesItem extends StatelessWidget {
  final CourseShortInfo item;

  const AllCoursesItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final bool? result = await context.read<CoursesBloc>().checkEnrollment(
          item.id,
        );

        if (!context.mounted) return;

        if (result != null) {
          Navigator.pushNamed(
            context,
            result ? AppRoutes.enrolledCoursePage : AppRoutes.singleCoursePage,
            arguments: item.id,
          );
        }
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 230.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      space8,
                      Text(
                        item.short_description,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      space8,
                      // CourseInfo(
                      //   '',
                      //   '',
                      //   0,
                      //   context,
                      //   isCertificateAvailble: true,
                      // ),
                      space8,
                      Row(
                        children: [
                          Text(
                            item.price?.isEmpty == true
                                ? context.localizations.free
                                : item.price ?? '',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(width: 10.w),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 2.h,
                            ),
                            decoration: BoxDecoration(
                              color: context.colors.accentContainerDefault
                                  .withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  '35%',
                                  style: TextStyle(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                    fontSize: 10.sp,
                                  ),
                                ),
                                Text(
                                  ' off',
                                  style: TextStyle(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                    fontSize: 10.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        '350 000 UZS',
                        style: TextStyle(
                          fontSize: 13.sp,
                          decoration: TextDecoration.lineThrough,
                          fontWeight: FontWeight.w400,
                          color: context.colors.fgMuted,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(width: 37.w),
            ClipRRect(
              borderRadius: BorderRadius.circular(4.r),
              child: CachedNetworkImage(
                imageUrl: item.thumbnail?.original_url ?? '',
                height: 60.w,
                width: 60.w,
                fit: BoxFit.fill,
                placeholder: (context, url) => Container(
                  height: 60.w,
                  width: 60.w,
                  color: Colors.grey[200],
                  child: Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (context, url, error) => Container(
                  height: 60.w,
                  width: 60.w,
                  decoration: BoxDecoration(
                    color: context.colors.neutralContainerDefault.withOpacity(
                      0.1,
                    ),
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/network_image_error_case.png',
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
