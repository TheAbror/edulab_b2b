import 'package:leti_mobile/widget_imports.dart';

class CourseDownloadItem extends StatefulWidget {
  final double radius;
  final Function onPressed;
  final double elevation;
  final double hightLightElevation;
  final double? height;
  final double padding;
  final DownloadableMaterialViewModel material;
  final String localPath;

  const CourseDownloadItem({
    super.key,
    this.radius = 0,
    required this.onPressed,
    this.elevation = 0,
    this.height,
    this.padding = 0,
    this.hightLightElevation = 0,
    required this.material,
    required this.localPath,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CourseDownloadItemState createState() => _CourseDownloadItemState();
}

class _CourseDownloadItemState extends State<CourseDownloadItem> {
  getAction(
    DownloadTaskStatus status,
    DownloadableMaterialViewModel material,
    BuildContext context,
  ) {
    if (status == DownloadTaskStatus.undefined) {
      FileDownloadUtils.requestDownload(
        context,
        material,
        widget.localPath,
        (String? downloadId) {
          if (downloadId != null) {
            context.read<LessonMaterialBloc>().updateFileDownloadId(
              widget.material.name,
              downloadId,
            );
          }
        },
      );
    }

    if (status == DownloadTaskStatus.running) {
      FileDownloadUtils.pauseDownload(material);
    }

    if (status == DownloadTaskStatus.paused) {
      FileDownloadUtils.resumeDownload(material);
    }

    if (status == DownloadTaskStatus.failed) {
      FileDownloadUtils.retryDownload(material);
    }
  }

  @override
  Widget build(BuildContext context) {
    final iconUrl = AppUtils.getIconByfileType(
      widget.material.src,
    );

    return Material(
      elevation: widget.elevation,
      color: Theme.of(context).colorScheme.background,
      borderRadius: BorderRadius.circular(widget.radius),
      child: MaterialButton(
        elevation: widget.elevation,
        highlightElevation: widget.hightLightElevation,
        padding: EdgeInsets.all(widget.padding),
        height: widget.height ?? 56.h,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.radius),
        ),
        onPressed: () {
          FileDownloadUtils.openFile(
            context,
            widget.material,
            widget.localPath,
            (String? downloadId) {
              if (downloadId != null) {
                context.read<LessonMaterialBloc>().updateFileDownloadId(
                  widget.material.name,
                  downloadId,
                );
              }
            },
          );
        },
        child: Container(
          height: widget.height,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: context.colors.neutralContainerSoft.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          margin: EdgeInsets.symmetric(vertical: 8.h),
          child: Column(
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    iconUrl,
                    width: 24.w,
                    height: 24.h,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Lecture Video (720p).mp4',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 14.sp),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          '920 MB',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: context.colors.fgMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Container(
                    decoration: BoxDecoration(
                      color: FileDownloadUtils.getDownloaderColor(
                        widget.material.status,
                      ),
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    child: CircularPercentIndicator(
                      lineWidth: 1.5,
                      animateFromLastPercent: true,
                      animation: true,
                      radius: 17.0,
                      percent: FileDownloadUtils.getProcessPercent(
                        widget.material.status,
                        widget.material,
                      ),
                      center: IconButton(
                        color: context.colors.float,
                        iconSize: 15.sp,
                        padding: EdgeInsets.zero,
                        style: const ButtonStyle(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        icon: FileDownloadUtils.getDownloadIcon(
                          widget.material.status,
                        ),
                        onPressed: () => getAction(
                          widget.material.status,
                          widget.material,
                          context,
                        ),
                      ),
                      backgroundColor: FileDownloadUtils.getDownloaderColor(
                        widget.material.status,
                      ),
                      progressColor: context.colors.float,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
