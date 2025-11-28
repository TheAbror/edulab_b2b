import 'package:leti_mobile/widget_imports.dart';

import 'user_profile_widgets.dart';

class AuthorProfilePage extends StatelessWidget {
  final String teacherName;

  const AuthorProfilePage({super.key, required this.teacherName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: userProfileAppBar(context, teacherName),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state.blocProgress == BlocProgress.IS_LOADING) {
            return const PrimaryLoader();
          }

          // if (state.blocProgress == BlocProgress.FAILED) {
          //   return const SomethingWentWrong();
          // }

          final item = state.teachersById;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserProfileInfo(
                  teacherName: teacherName,
                  item: item,
                  isJobTitleNeeded: true,
                  statistics: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Statistics(
                          'Students',
                          item.total_students_number,
                          context,
                        ),
                        Statistics(
                          'Reviews',
                          item.total_reviews_number,
                          context,
                        ),
                        Statistics('Courses', item.courses_number, context),
                        Statistics(
                          'Rating',
                          item.average_rating.toInt(),
                          context,
                        ),
                      ],
                    ),
                  ),
                ),
                AuthorProfileWebsites(
                  text: const ['Website', 'LinkedIn', 'YouTube', 'Instagram'],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    'About me',
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                space10,

                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 16.w),
                //   child: item.about_me.isEmpty
                //       ? Center(
                //           child: Text(
                //             'The teacher has not filled in any information about himself/herself',
                //             textAlign: TextAlign.center,
                //           ),
                //         )
                //       : LongTextWithOpacity(
                //           text: item.about_me,
                //         ),
                // ),
                space10,

                //
                // item.about_me.length < 200
                //     ? SizedBox.shrink()
                //     : ShowMoreTextWithOpacity(text: 'Show more'),
                // //
                space28,

                // BlocBuilder<CoursesBloc, CoursesState>(
                //   builder: (context, state) {
                //     final item = state.shortCourseInfo;

                //     if (item.isEmpty) {
                //       return Center(
                //         child: Text(
                //           'The teacher has not added any courses',
                //           textAlign: TextAlign.center,
                //         ),
                //       );
                //     }

                //     return RecommendedForYou(
                //       headline: 'My courses',
                //       length: item.length,
                //       onTapViewAll: () {
                //         Navigator.pushNamed(context,AppRoutes.AllCoursesPage);
                //       },
                //       openThisCourse: (int id) {
                //         context.read<CoursesBloc>().getSingleCourseByItsId(id);

                //         Navigator.pushNamed(context,AppRoutes.singleCoursePage);
                //       },
                //       imageUrl: ['item.map((e) => e.thumbnail.original_url).toList()'],
                //       title: item.map((e) => e.name).toList(),
                //       subTitle: item.map((e) => e.short_description).toList(),
                //       indexes: item.map((e) => e.id).toList(),
                //       isCertificateAvailble: item.map((e) => e.certificate).toList(),
                //     );
                //   },
                // ),
                space10,
              ],
            ),
          );
        },
      ),
    );
  }
}
