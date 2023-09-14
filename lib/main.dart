import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_store_app/auth/login.dart';
import 'package:multi_store_app/auth/signup.dart';
import 'package:multi_store_app/screens/main_screans/customer_home.dart';
import 'package:multi_store_app/screens/main_screans/supplier_home_screen.dart';
import 'package:multi_store_app/screens/main_screans/welcome.dart';

import 'package:permission_handler/permission_handler.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    requestPermissions();
  }

  Future<bool> requestPermissions() async {
    // Request camera permission
    final cameraStatus = await Permission.camera.request();
    if (cameraStatus.isDenied) {
      // Camera permission denied
      return false;
    }

    // Request storage permission
    final storageStatus = await Permission.storage.request();
    if (storageStatus.isDenied) {
      // Storage permission denied
      return false;
    }
    return true;
  }

  //This widget is the root of ouer application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      //This widget is the main screan that is showing now on the app CustomerHomeScrean().
      initialRoute: "/welcome_screen",
      routes: {
        '/welcome_screen': ((context) => const WelcomeScreen()),
        '/customer_screen': ((context) => const CustomerHomeScrean()),
        '/supplier_screen': ((context) => const SupplierHomeScreen()),
        '/signup': ((context) => const RgisterScreen()),
        '/login': ((context) => const LogIn()),
      },
    );
  }
}
