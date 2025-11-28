import 'package:leti_mobile/widget_imports.dart';

class HomeAuthorsItem extends StatelessWidget {
  final String authorName;
  final String authorPhoto;
  final String position;
  final String count;
  final VoidCallback onTap;

  const HomeAuthorsItem({
    super.key,
    required this.authorName,
    required this.authorPhoto,
    required this.position,
    required this.count,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.all(12.w),
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            width: 2.w,
            color: context.colors.borderMuted.withOpacity(0.15),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4.r),
              child: authorPhoto.isEmpty
                  ? Container(
                      height: 80.w,
                      width: 80.w,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.outlineVariant,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Icon(
                        Icons.person,
                        size: 44.sp,
                        color: Theme.of(context).colorScheme.background,
                      ),
                    )
                  : CachedNetworkImage(
                      imageUrl: authorPhoto,
                      height: 80.w,
                      width: 80.w,
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
                          color: context.colors.neutralContainerDefault
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
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    authorName,
                    style: TextStyle(
                      fontSize: 16.sp,
                      letterSpacing: -1,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4.w),
                  Text(
                    position,
                    style: TextStyle(
                      fontSize: 13.sp,
                      letterSpacing: -1,
                      fontWeight: FontWeight.w400,
                      color: context.colors.fgMuted,
                    ),
                  ),
                  space20,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          '$count ${context.localizations.coursesWithnumber}',
                          style: TextStyle(
                            fontSize: 13.sp,
                            letterSpacing: -1,
                            fontWeight: FontWeight.w400,
                            color: context.colors.fgMuted,
                          ),
                        ),
                      ),
                      Assets.icons.homeTabIcons.star.image(
                        height: 16.w,
                        width: 16.w,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        '5',
                        style: TextStyle(
                          fontSize: 13.sp,
                          letterSpacing: -1,
                          fontWeight: FontWeight.w400,
                          color: context.colors.fgMuted,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
