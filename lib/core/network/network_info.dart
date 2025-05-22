import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfo {
  Future<bool> get isConnect;
  Stream<List<ConnectivityResult>> get onConnectionChanged;
}

class NetworkInfoImpl extends NetworkInfo {
  final Connectivity connectivity;
  NetworkInfoImpl({required this.connectivity});

  @override
  Future<bool> get isConnect => _checkConnection();

  @override
  Stream<List<ConnectivityResult>> get onConnectionChanged =>
      connectivity.onConnectivityChanged;

  Future<bool> _checkConnection() async {
    bool hasConnection = false;
    final List<ConnectivityResult> connectivityResult =
        await (connectivity.checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.ethernet)) {
      // Mobile network available.
      // Wi-fi is available.
      // Note for Android:
      // When both mobile and Wi-Fi are turned on system will return Wi-Fi only as active network type
      // Ethernet connection available.
      hasConnection = true;
    }

    return hasConnection;
  }
}
