import 'package:leti_mobile/widget_imports.dart';

class PlayListCourseCard extends StatelessWidget {
  final String courseTopicText;
  final String topicText;
  final String durationText;
  final double percent;
  final ThisCourseStatus status;
  final VoidCallback onTap;

  const PlayListCourseCard({
    super.key,
    required this.courseTopicText,
    required this.topicText,
    required this.durationText,
    required this.percent,
    required this.status,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
      contentPadding: EdgeInsets.all(0),
      dense: true,
      horizontalTitleGap: 0.0,
      minLeadingWidth: 0,
      child: ExpansionTile(
        tilePadding: EdgeInsets.all(0.w),
        title: Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: Text(
            courseTopicText,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
              letterSpacing: -1,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        iconColor: context.colors.fgDefault,
        controlAffinity: ListTileControlAffinity.leading,
        children: [
          ListView.builder(
            itemCount: 5,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, innerIndex) {
              return GestureDetector(
                onTap: onTap,
                behavior: HitTestBehavior.opaque,
                child: Container(
                  padding: EdgeInsets.all(10.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.green,
                            child: Icon(
                              Icons.done,
                              size: 15,
                              color: context.colors.float,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              topicText,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp,
                                letterSpacing: -1,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            // padding: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                            decoration: BoxDecoration(
                              color: FileDownloadUtils.getDownloaderColor(
                                DownloadTaskStatus.undefined,
                              ),
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                            child: CircularPercentIndicator(
                              lineWidth: 0.1,
                              animateFromLastPercent: true,
                              animation: true,
                              radius: 12.0,
                              percent: FileDownloadUtils.getProcessPercent(
                                DownloadTaskStatus.undefined,
                                DownloadableMaterialViewModel(
                                  name: '',
                                  src: '',
                                  url: '',
                                  status: DownloadTaskStatus.undefined,
                                  progress: 0,
                                ),
                              ),
                              center: IconButton(
                                color: context.colors.float,
                                iconSize: 12.sp,
                                padding: EdgeInsets.zero,
                                style: const ButtonStyle(
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                icon: FileDownloadUtils.getDownloadIcon(
                                  DownloadTaskStatus.undefined,
                                ),
                                onPressed: () {},
                              ),
                              backgroundColor:
                                  FileDownloadUtils.getDownloaderColor(
                                    DownloadTaskStatus.undefined,
                                  ),
                              progressColor: context.colors.float,
                            ),
                          ),
                        ],
                      ),
                      space8,
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 2.h,
                            ),
                            decoration: BoxDecoration(
                              color: context.colors.successDefault.withOpacity(
                                0.1,
                              ),
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Text(
                              durationText,
                              style: TextStyle(fontSize: 10.sp),
                            ),
                          ),
                          SizedBox(width: 4.h),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 2.h,
                            ),
                            decoration: BoxDecoration(
                              color: context.colors.successDefault.withOpacity(
                                0.1,
                              ),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Text(
                              durationText,
                              style: TextStyle(fontSize: 10.sp),
                            ),
                          ),
                        ],
                      ),
                      space8,
                      LinearPercentIndicator(
                        animation: true,
                        padding: EdgeInsets.zero,
                        lineHeight: 4.h,
                        animationDuration: 1000,
                        percent: percent,
                        barRadius: Radius.circular(8.r),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        progressColor: const Color(0XFF1FD57E),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
