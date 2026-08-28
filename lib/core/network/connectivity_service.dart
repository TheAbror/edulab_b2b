import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

/// Watches real internet reachability without polling.
///
/// The OS level connectivity stream is event driven and costs no network
/// traffic, so it covers the common cases (airplane mode, wifi off) for free.
/// A single lightweight request is issued only when that stream reports a
/// change, which is what catches "attached to wifi, but nothing behind it".
class ConnectivityService {
  ConnectivityService._();

  static final ConnectivityService instance = ConnectivityService._();

  /// Answers 204 with an empty body, so a probe costs a few dozen bytes.
  static final Uri _probe = Uri.parse('https://www.gstatic.com/generate_204');

  static const Duration _probeTimeout = Duration(seconds: 5);

  final Connectivity _connectivity = Connectivity();
  final http.Client _client = http.Client();

  /// Emits whenever the OS reports a connectivity change, after confirming the
  /// link actually reaches the internet.
  Stream<bool> get onStatusChange =>
      _connectivity.onConnectivityChanged.asyncMap(_verify);

  /// One off check, for app start and app resume.
  Future<bool> get hasConnection async =>
      _verify(await _connectivity.checkConnectivity());

  Future<bool> _verify(List<ConnectivityResult> results) async {
    final bool hasLink = results.any(
      (ConnectivityResult result) => result != ConnectivityResult.none,
    );

    if (!hasLink) return false;

    try {
      final http.Response response = await _client
          .head(_probe)
          .timeout(_probeTimeout);

      // Any HTTP answer proves the device reached a server, so the connection
      // is live even when the status code itself is an error.
      return response.statusCode >= 100 && response.statusCode < 600;
    } catch (_) {
      return false;
    }
  }
}
