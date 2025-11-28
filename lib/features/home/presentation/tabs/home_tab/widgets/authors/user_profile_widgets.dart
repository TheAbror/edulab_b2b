import 'package:leti_mobile/widget_imports.dart';

class UserProfileInfo extends StatelessWidget {
  final String teacherName;
  final TeacherModel item;
  final bool isJobTitleNeeded;
  final Widget statistics;

  const UserProfileInfo({
    super.key,
    required this.teacherName,
    required this.item,
    required this.statistics,
    this.isJobTitleNeeded = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Theme.of(context).colorScheme.background,
        border: Border.all(
          color: Theme.of(context).colorScheme.onSecondaryContainer,
          width: 2.w,
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                CircleAvatar(radius: 24),
                SizedBox(width: 12.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(teacherName),
                    isJobTitleNeeded ? space4 : SizedBox.shrink(),
                    isJobTitleNeeded
                        ? Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 4.w,
                              vertical: 2.h,
                            ),
                            decoration: BoxDecoration(
                              color: context.colors.successDefault,
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Text(
                              item.job_title,
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: Theme.of(context).colorScheme.background,
                              ),
                            ),
                          )
                        : SizedBox.shrink(),
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              padding: EdgeInsets.symmetric(vertical: 8.w),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.all(
                  Radius.circular(defaultRadius.r),
                ),
              ),
              child: Center(
                child: Text(
                  'Follow',
                  style: TextStyle(
                    letterSpacing: -0.5,
                    fontSize: 16.sp,
                    color: Theme.of(context).colorScheme.background,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          space16,
          Divider(
            color: Theme.of(context).colorScheme.onSecondaryContainer,
            height: 1.h,
          ),
          statistics,
        ],
      ),
    );
  }
}

Column Statistics(String topText, int bottomText, BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        topText,
        style: TextStyle(
          fontSize: 12.sp,
          color: context.colors.fgMuted,
          fontWeight: FontWeight.w400,
        ),
      ),
      space4,
      Text(
        bottomText.toString(),
        style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w500),
      ),
    ],
  );
}

AppBar userProfileAppBar(BuildContext context, String name) {
  return AppBar(
    automaticallyImplyLeading: false,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomAppBarBackButton(),
        SizedBox(
          width: 256.w,
          child: Text(name, style: TextStyle(fontSize: 16.sp)),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.studentProfilePage);
          },
          child: Assets.icons.homeTabIcons.shareIcon.svg(
            colorFilter: ColorFilter.mode(
              Theme.of(context).colorScheme.secondaryContainer,
              BlendMode.srcIn,
            ),
          ),
        ),
      ],
    ),
  );
}

class AuthorProfileWebsites extends StatelessWidget {
  final List<String> text;

  const AuthorProfileWebsites({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Theme.of(context).colorScheme.onSecondaryContainer,
          width: 2.w,
        ),
      ),
      child: ListView.separated(
        itemCount: 4,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SvgPicture.asset(assetName)
                Assets.icons.courses.clock.svg(),
                SizedBox(width: 12.w),
                Text(
                  text[index],
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: Theme.of(context).colorScheme.onSecondaryContainer,
            height: 1.h,
          );
        },
      ),
    );
  }
}
