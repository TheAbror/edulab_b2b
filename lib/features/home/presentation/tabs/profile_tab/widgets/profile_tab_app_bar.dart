import 'package:edulab_b2b/widget_imports.dart';

class ProfileTabAppBar extends StatefulWidget {
  const ProfileTabAppBar({super.key});

  @override
  State<ProfileTabAppBar> createState() => _ProfileTabAppBarState();
}

class _ProfileTabAppBarState extends State<ProfileTabAppBar> {
  final db = PreferencesServices.getUserInfo();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.editProfilePage);
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.all(12.w),
        margin: EdgeInsets.only(bottom: 36.h),
        decoration: BoxDecoration(
          color: context.colors.bgSurface3,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            ClipOval(
              child: CachedNetworkImage(
                imageUrl: db?.profile_photo?.originalUrl ?? '',
                width: 48.w,
                height: 48.w,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  width: 48.w,
                  height: 48.w,
                  color: Colors.grey[200],
                  child: Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (context, url, error) => Container(
                  width: 48.w,
                  height: 48.w,
                  color: context.colors.neutralContainerDefault.withOpacity(
                    0.1,
                  ),
                  child: Icon(Icons.person),
                ),
              ),
            ),

            SizedBox(width: 8.w),
            SizedBox(
              width: 220.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${db?.lastName ?? ''} ${db?.firstName ?? ''}",
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.17,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 4.w,
                      vertical: 2.h,
                    ),
                    decoration: BoxDecoration(
                      color: context.colors.infoDefault,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Text(
                      db?.account_type_str?.makeFirstCapital() ?? 'Role',
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.background,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Assets.icons.courses.arrowRight.svg(
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.surfaceTint,
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
