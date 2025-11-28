// ignore_for_file: unused_element

// import 'dart:io';
// import 'dart:async';
// import 'package:connectivity_plus/connectivity_plus.dart';

//  String string;

//     switch (_source.keys.toList()[0]) {
//       case ConnectivityResult.mobile:
//         string = 'Mobile: Online';
//         break;
//       case ConnectivityResult.wifi:
//         string = 'WiFi: Online';
//         break;

//       case ConnectivityResult.none:
//       default:
//         string = 'You`re offline';
//     }

// Map _source = {ConnectivityResult.none: false};
// final MyConnectivity _connectivity = MyConnectivity.instance;

// class MyConnectivity {
//   MyConnectivity._();

//   // Future<bool> get isConnected;

//   static final _instance = MyConnectivity._();
//   static MyConnectivity get instance => _instance;
//   final _connectivity = Connectivity();
//   final _controller = StreamController.broadcast();
//   Stream get myStream => _controller.stream;

//   void initialise() async {
//     ConnectivityResult result = await _connectivity.checkConnectivity();
//     _checkStatus(result);
//     _connectivity.onConnectivityChanged.listen((result) {
//       _checkStatus(result);
//     });
//   }

//   void _checkStatus(ConnectivityResult result) async {
//     bool isOnline = false;
//     try {
//       final result = await InternetAddress.lookup('example.com');
//       isOnline = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
//     } on SocketException catch (_) {
//       isOnline = false;
//     }
//     _controller.sink.add({result: isOnline});
//   }

//   void disposeStream() => _controller.close();
// }
