import 'package:leti_mobile/widget_imports.dart';

class SingleCourseContent extends StatelessWidget {
  final SingleCourseState state;

  const SingleCourseContent({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return state.fullCourseInfo.syllabus?.courseContent?.isNotEmpty == true
        ? ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 24.h),
            itemCount: state.fullCourseInfo.syllabus?.courseContent?.length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final title =
                  state.fullCourseInfo.syllabus?.courseContent?[index];

              return CourseInfoMaterialExpansionItem(
                title: title?.title ?? '',
                subTitle: title?.description ?? '',
                chapterInfoText:
                    title?.topics.map((e) => e.title).toList() ?? [],
                lessonsLength: title?.topics.length ?? 0,
                topics: title?.topics ?? [],
              );
            },
          )
        : Center(
            child: AppText.paragraph1('No results'),
          );
  }
}

class CourseInfoMaterialExpansionItem extends StatelessWidget {
  final String title;
  final String subTitle;
  final List<String> chapterInfoText;
  final int lessonsLength;
  final List<TopicModel> topics;

  const CourseInfoMaterialExpansionItem({
    super.key,
    required this.title,
    required this.subTitle,
    required this.chapterInfoText,
    required this.lessonsLength,
    required this.topics,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      shape: Border(),
      tilePadding: EdgeInsets.symmetric(vertical: 0.h),
      title: Padding(
        padding: EdgeInsets.only(bottom: 4.h),
        child: Text(
          title,
          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
        ),
      ),

      subtitle: Text(
        subTitle,
        style: TextStyle(color: Theme.of(context).colorScheme.surfaceTint),
        maxLines: 1,
      ),
      children: <Widget>[
        Divider(
          thickness: 1.h,
          color: context.colors.borderMuted.withOpacity(0.15),
        ),
        space12,
        ListView.separated(
          itemCount: lessonsLength,
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final topic = topics[index];
            final chapterID = topic.chapterId;
            final courseID = topic.courseId;

            return CourseInfoChapterInfoText(
              onTap: () {
                context.read<SingleCourseBloc>().getSingleStepByID(
                  chapterId: chapterID ?? 0,
                  courseId: courseID ?? 0,
                  topicId: topic.id,
                );
              },
              text: chapterInfoText[index],
              status: topic.status,
            );
          },
          separatorBuilder: (context, index) => Padding(
            padding: EdgeInsets.only(left: 8.w),
            child: Divider(color: context.colors.borderMuted.withOpacity(0.15)),
          ),
        ),
        SizedBox(height: 18.h),
      ],
    );
  }
}
