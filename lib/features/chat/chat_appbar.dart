import 'package:leti_mobile/widget_imports.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.1,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomAppBarBackButton(),
          SizedBox(
            width: 256.w,
            child: Row(
              children: [
                CircleAvatar(),
                SizedBox(width: 8.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Saida Rakhmatova', style: TextStyle(fontSize: 14.sp)),
                    Text(
                      'Last seen 5 min ago',
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: context.colors.fgMuted,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Assets.icons.courses.moreIcon.svg(),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
