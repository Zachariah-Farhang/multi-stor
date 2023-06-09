import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_store_app/auth/customer_signup.dart';
import 'package:multi_store_app/screens/main_screens/customer_home.dart';
import 'package:multi_store_app/screens/main_screens/supplier_home_screen.dart';
import 'package:multi_store_app/screens/main_screens/welcome.dart';

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

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  //This widget is the root of our application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //This widget is the main screen that is showing now on the app CustomerHomeScreen().
      initialRoute: "/welcome_screen",
      routes: {
        '/welcome_screen': ((context) => const WelcomeScreen()),
        '/customer_screen': ((context) => const CustomerHomeScrean()),
        '/supplier_screen': ((context) => const SupplierHomeScreen()),
        '/customer_signup': ((context) => const CustomerRgisterScreen()),
      },
    );
  }
}
