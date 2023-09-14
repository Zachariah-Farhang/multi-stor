import 'dart:async';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectivityService {
  final StreamController<dynamic> _connectivityController =
      StreamController<dynamic>.broadcast();
  final InternetConnectionChecker _connectivity =
      InternetConnectionChecker.createInstance(
          checkInterval: const Duration(milliseconds: 10),
          checkTimeout: const Duration(seconds: 5));

  ConnectivityService() {
    // Listen to connectivity changes
    _connectivity.onStatusChange.listen(
      (event) {
        if (!_connectivityController.isClosed) {
          _connectivityController.add(event);
        }
      },
    );

    // Start checking internet connectivity
  }

  Stream<dynamic> get connectivityStream => _connectivityController.stream;

  void dispose() {
    _connectivityController.close();
  }
}
