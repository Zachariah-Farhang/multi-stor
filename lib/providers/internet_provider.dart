import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ConnectivityProvider extends ChangeNotifier {
  bool _isInternetStable = false;

  bool get isInternetStable => _isInternetStable;

  ConnectivityProvider() {
    _checkInternetStability();
  }

  Future<void> _checkInternetStability() async {
    while (true) {
      try {
        final response = await http.get(Uri.parse('https://www.google.com'));
        if (response.statusCode == 200) {
          if (!_isInternetStable) {
            _isInternetStable = true;
            debugPrint(' internet stablatied');
            notifyListeners(); // Notify listeners when the internet becomes stable.
          }
        } else {
          if (_isInternetStable) {
            _isInternetStable = false;
            debugPrint(' internet not stablatied');

            notifyListeners(); // Notify listeners when the internet becomes unstable.
          }
        }
      } catch (e) {
        if (_isInternetStable) {
          _isInternetStable = false;
          debugPrint(' internet not stablatied');

          notifyListeners(); // Notify listeners when the internet becomes unstable.
        }
      }
      await Future.delayed(
          const Duration(seconds: 1)); // Check every 30 seconds.
    }
  }
}
