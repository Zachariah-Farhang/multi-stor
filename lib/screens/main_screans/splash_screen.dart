import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void delayedTask() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.popAndPushNamed(context, "/welcome_screen");
    });
  }

  @override
  void initState() {
    super.initState();
    delayedTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(color: Colors.black54),
        child: const CupertinoActivityIndicator(
          color: Colors.amber,
          radius: 40,
        ),
      ),
    );
  }
}
