import 'package:leti_mobile/widget_imports.dart';

import 'user_profile_widgets.dart';

class StudentProfilePage extends StatelessWidget {
  final String teacherName;

  const StudentProfilePage({super.key, required this.teacherName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: userProfileAppBar(context, 'Jacob Jones'),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state.blocProgress == BlocProgress.IS_LOADING) {
            return const PrimaryLoader();
          }

          if (state.blocProgress == BlocProgress.FAILED) {
            return const SomethingWentWrong();
          }

          final item = state.teachersById;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserProfileInfo(
                  teacherName: 'Jacob Jones',
                  item: item,
                  statistics: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Statistics(
                          'Followers',
                          item.total_students_number,
                          context,
                        ),
                        Statistics(
                          'Problems solved',
                          item.total_reviews_number,
                          context,
                        ),
                        Statistics(
                          'Certificates',
                          item.average_rating.toInt(),
                          context,
                        ),
                      ],
                    ),
                  ),
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
                //             'The student has not filled in any information about himself/herself',
                //             textAlign: TextAlign.center,
                //           ),
                //         )
                //       : LongTextWithOpacity(
                //           text: item.about_me,
                //         ),
                // ),
                // space10,

                //
                // item.about_me.length < 200
                //     ? SizedBox.shrink()
                //     : ShowMoreTextWithOpacity(text: 'Show more'),
                //
                space28,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    'Certificates',
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                space16,
                // ListView.builder(
                //   itemCount: 2,
                //   shrinkWrap: true,
                //   physics: NeverScrollableScrollPhysics(),
                //   itemBuilder: (context, index) {
                //     return CertificatesItem(
                //       text: 'Foundations of User Experience (UX) Design',
                //       certificateUrl: '',
                //       grade: 'Grade Achieved: 95.55%',
                //       buttonText: 'View certificate',
                //     );
                //   },
                // ),
              ],
            ),
          );
        },
      ),
    );
  }
}
