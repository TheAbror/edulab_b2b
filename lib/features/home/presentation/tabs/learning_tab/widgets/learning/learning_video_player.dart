// import 'package:chewie/chewie.dart';
// import 'package:video_player/video_player.dart';

// final videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(
//     'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'));

// await videoPlayerController.initialize();

// final chewieController = ChewieController(
//   videoPlayerController: videoPlayerController,
//   autoPlay: true,
//   looping: true,
// );

// final playerWidget = Chewie(
//   controller: chewieController,
// );

// AspectRatio VideoPlayer(String url) {
//   return AspectRatio(
//     aspectRatio: 16 / 9,
//     child: BetterPlayer.network(
//       url,
//       betterPlayerConfiguration: const BetterPlayerConfiguration(
//         fit: BoxFit.contain,
//         deviceOrientationsOnFullScreen: [
//           DeviceOrientation.portraitUp,
//           DeviceOrientation.landscapeLeft,
//           DeviceOrientation.landscapeRight,
//         ],
//         deviceOrientationsAfterFullScreen: [
//           DeviceOrientation.portraitUp,
//           DeviceOrientation.landscapeLeft,
//           DeviceOrientation.landscapeRight
//         ],
//       ),
//     ),
//   );
// }
