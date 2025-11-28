import 'package:leti_mobile/widget_imports.dart';

class HomeTabAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeTabAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Assets.icons.main.letiSmallLogoSvg.svg(
                colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.primary,
                  BlendMode.srcIn,
                ),
                height: 26.w,
                width: 95.w,
              ),
              Assets.icons.main.notification.svg(),
            ],
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}


//  title: Row(
//         children: [
//           userData?.gPhotoUrl != null && userData?.gPhotoUrl?.isNotEmpty == true
//               ? CircleAvatar(
//                   backgroundImage: NetworkImage(userData?.gPhotoUrl ?? ''),
//                 )
//               : SizedBox(),
//           SizedBox(width: 8.w),
//           Text(
//             userData?.gDispayName ?? 'error',
//             style: TextStyle(color: AppColors.foregroundDefault),
//           ),
//         ],
//       ),