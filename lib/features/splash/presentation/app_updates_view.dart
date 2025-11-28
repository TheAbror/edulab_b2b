import 'package:leti_mobile/widget_imports.dart';

// class AppUpdatesView extends StatelessWidget {
//   const AppUpdatesView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<SplashBloc, SplashState>(
//       builder: (context, state) {
//         var homeState = context.read<HomeBloc>().state;
//         final themeSystem = MediaQuery.of(context).platformBrightness;

//         return Container(
//           color: Theme.of(context).colorScheme.background,
//           padding: EdgeInsets.symmetric(horizontal: 24.w),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: <Widget>[
//               const Spacer(),
//               homeState.isLightTheme
//                   ? themeSystem == Brightness.light
//                       ? Assets.icons.main.logoDark1.image()
//                       : Assets.icons.main.logoBig1.image()
//                   : Assets.icons.main.logoBig1.image(),
//               Expanded(
//                 flex: 8,
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 8.w),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       state.appVersionData.showMaintanance
//                           ? Assets.images.stores.maintenance.svg(width: 170.w)
//                           : Platform.isAndroid
//                               ? Assets.images.stores.googlePlay.image(width: 80.w)
//                               : Assets.images.stores.iosAppStore.image(width: 80.w),
//                       space40,
//                       Text(
//                         state.appVersionData.title,
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontSize: 14.sp,
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                       SizedBox(height: 10.h),
//                       Text(
//                         state.appVersionData.description,
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontSize: 16.sp,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               if (!state.appVersionData.showMaintanance)
//                 Padding(
//                   padding: EdgeInsets.only(top: 60.h),
//                   child: Column(
//                     children: [
//                       ActionButton(
//                         text: 'Update now'.toUpperCase(),
//                         onTap: () => _launchUrl(Platform.isAndroid
//                             ? state.appVersionData.androidStoreUrl
//                             : state.appVersionData.iosStoreUrl),
//                       ),
//                       if (state.buildNumber < state.latestAppVersion)
//                         Padding(
//                           padding: EdgeInsets.only(top: 10.h),
//                           child: ActionButton(
//                             isFilled: false,
//                             text: 'Not now'.toUpperCase(),
//                             onTap: () {
//                               // context.read<SplashBloc>().setupInitialSettings();
//
//  Navigator.pushNamed(context, AppRoutes.rootPage),

//                             },
//                           ),
//                         ),
//                       SizedBox(height: 60.h),
//                     ],
//                   ),
//                 )
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

// ignore: unused_element
Future<void> _launchUrl(String url) async {
  final Uri parsedUrl = Uri.parse(url);

  if (!await launchUrl(parsedUrl)) {
    throw Exception('Could not launch $parsedUrl');
  }
}
