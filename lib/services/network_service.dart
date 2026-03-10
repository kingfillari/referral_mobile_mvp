import 'package:connectivity_plus/connectivity_plus.dart';

/// NetworkService: Detects internet availability
class NetworkService {
  final Connectivity _connectivity = Connectivity();

  /// Check current connection
  Future<bool> isConnected() async {
    final result = await _connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }

  /// Stream to listen to connectivity changes
  Stream<ConnectivityResult> get onConnectivityChanged =>
      _connectivity.onConnectivityChanged;
}