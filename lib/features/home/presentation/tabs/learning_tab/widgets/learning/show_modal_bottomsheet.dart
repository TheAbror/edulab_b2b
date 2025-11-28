import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'this_course_status.dart';
import '../play_list_items/playlist_course_card.dart';
import '../play_list_items/playlist_top_title_widget.dart';

Future<dynamic> playListBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    isDismissible: true,
    isScrollControlled: true,
    builder: (context) => DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.5,
      maxChildSize: 0.9,
      minChildSize: 0.4,
      builder: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                const PlayListTopTitleWidget(),
                SizedBox(height: 10.h),
                ListView.builder(
                  itemCount: 3,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return PlayListCourseCard(
                      courseTopicText: 'Chapter 1 - What you`ll learn',
                      topicText:
                          '1.1 Guidance in Applying for Continuing Education or Professional Development Credit',
                      durationText: '4 min',
                      percent: 1,
                      onTap: () {},
                      status: ThisCourseStatus.completed,
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}
