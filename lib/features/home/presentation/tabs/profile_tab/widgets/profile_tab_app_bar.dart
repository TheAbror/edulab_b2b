import 'package:edulab_b2b/widget_imports.dart';

class ProfileTabAppBar extends StatefulWidget {
  const ProfileTabAppBar({super.key});

  @override
  State<ProfileTabAppBar> createState() => _ProfileTabAppBarState();
}

class _ProfileTabAppBarState extends State<ProfileTabAppBar> {
  @override
  Widget build(BuildContext context) {
    final db = PreferencesServices.getUserInfo();

    return GestureDetector(
      onTap: () async {
        await Navigator.pushNamed(context, AppRoutes.editProfilePage);
        // Name/photo/avatar type may have changed on the edit screen.
        if (context.mounted) setState(() {});
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.only(
          left: 8.w,
          right: 16.w,
          top: 8.h,
          bottom: 8.h,
        ),
        decoration: BoxDecoration(
          color: context.colors.bgSurface1,
          borderRadius: BorderRadius.circular(999.r),
        ),
        child: Row(
          children: [
            ProfileAvatarImage(db: db, size: 48.w),

            SizedBox(width: 8.w),
            Expanded(
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
                      color: context.colors.neutralContainerDefault.withOpacity(
                        0.1,
                      ),
                      borderRadius: BorderRadius.circular(999.r),
                    ),
                    child: Text(
                      db?.account_type_str?.makeFirstCapital() ?? 'Role',
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                        color: context.colors.neutralOnContainer,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            Assets.icons.courses.arrowRight.svg(
              width: 20.w,
              height: 20.w,
              colorFilter: ColorFilter.mode(
                context.colors.fgMuted,
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
