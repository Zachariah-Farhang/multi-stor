import 'package:flutter/material.dart';

class Snackbar {
  final GlobalKey<ScaffoldMessengerState> key;
  final String content;
  const Snackbar({required this.key, required this.content});
  void showsnackBar() {
    key.currentState!.hideCurrentSnackBar();
    key.currentState!.showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.grey,
        content: Text(
          content,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
