import 'package:flutter/material.dart';

class Snackbar {
  final GlobalKey<ScaffoldMessengerState> key;
  final String content;
  const Snackbar(this.key, this.content);
  void showsnackBar() {
    key.currentState!.hideCurrentSnackBar();
    key.currentState!.showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.grey.shade200,
        content: Text(content,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 18,
                color: Colors.black54,
                fontWeight: FontWeight.bold)),
      ),
    );
  }
}
