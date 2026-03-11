import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {

  final Connectivity _connectivity = Connectivity();

  StreamController<bool> connectionController =
      StreamController<bool>.broadcast();

  ConnectivityService() {
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<bool> checkConnection() async {

    final result = await _connectivity.checkConnectivity();

    return result != ConnectivityResult.none;

  }

  void _updateConnectionStatus(ConnectivityResult result) {

    if (result == ConnectivityResult.none) {

      connectionController.add(false);

    } else {

      connectionController.add(true);

    }

  }

  Stream<bool> get connectionStream => connectionController.stream;

  void dispose() {

    connectionController.close();

  }

}
