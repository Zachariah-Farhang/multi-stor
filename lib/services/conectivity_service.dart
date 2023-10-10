import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ConnectivityService extends ChangeNotifier {
  bool _isInternetStable = false;

  bool get isInternetStable => _isInternetStable;

  Future<void> checkInternetStability() async {
    while (true) {
      try {
        final response = await http.get(Uri.parse('https://www.google.com'));
        if (response.statusCode == 200) {
          if (!_isInternetStable) {
            _isInternetStable = true;
            notifyListeners(); // Notify listeners when the internet becomes stable.
          }
        } else {
          if (_isInternetStable) {
            _isInternetStable = false;
            notifyListeners(); // Notify listeners when the internet becomes unstable.
          }
        }
      } catch (e) {
        if (_isInternetStable) {
          _isInternetStable = false;
          notifyListeners(); // Notify listeners when the internet becomes unstable.
        }
      }
      await Future.delayed(
          const Duration(milliseconds: 500)); // Check every 5 minutes.
    }
  }
}
