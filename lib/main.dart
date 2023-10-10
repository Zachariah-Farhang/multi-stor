import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_store_app/auth/login.dart';
import 'package:multi_store_app/auth/signup.dart';
import 'package:multi_store_app/providers/cart_provider.dart';
import 'package:multi_store_app/providers/internet_provider.dart';
import 'package:multi_store_app/providers/wish_provider.dart';
import 'package:multi_store_app/screens/main_screans/customer_home_screen.dart';
import 'package:multi_store_app/screens/main_screans/supplier_home_screen.dart';
import 'package:multi_store_app/screens/main_screans/welcome.dart';

import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => Cart(),
    ),
    ChangeNotifierProvider(
      create: (_) => Wish(),
    ),
    ChangeNotifierProvider(
      create: (_) => ConnectivityProvider(),
    ),
  ], child: const MyApp()));
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
  }

  //This widget is the root of ouer application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Kanun').copyWith(
        snackBarTheme: const SnackBarThemeData(
            contentTextStyle: TextStyle(
                fontSize: 16,
                color: Colors.black87,
                fontFamily: 'Kanun',
                fontWeight: FontWeight.bold)),
        // textTheme: const TextTheme(
        //   // Display Styles
        //   displayLarge: TextStyle(
        //       fontFamily: 'Kanun',
        //       fontSize: 40,
        //       fontWeight: FontWeight.bold,
        //       color: Colors.black54),
        //   displayMedium: TextStyle(
        //       fontFamily: 'Kanun',
        //       fontSize: 32,
        //       fontWeight: FontWeight.bold,
        //       color: Colors.black54),
        //   displaySmall: TextStyle(
        //       fontFamily: 'Kanun',
        //       fontSize: 24,
        //       fontWeight: FontWeight.bold,
        //       color: Colors.black54),

        //   // Headline Styles
        //   headlineLarge: TextStyle(
        //       fontFamily: 'Kanun',
        //       fontSize: 28,
        //       fontWeight: FontWeight.bold,
        //       color: Colors.black54),
        //   headlineMedium: TextStyle(
        //       fontFamily: 'Kanun',
        //       fontSize: 22,
        //       fontWeight: FontWeight.bold,
        //       color: Colors.black54),
        //   headlineSmall: TextStyle(
        //       fontFamily: 'Kanun',
        //       fontSize: 18,
        //       fontWeight: FontWeight.bold,
        //       color: Colors.black54),

        //   // Title Styles
        //   titleLarge: TextStyle(
        //       fontFamily: 'Kanun',
        //       fontSize: 24,
        //       fontWeight: FontWeight.bold,
        //       color: Colors.black54),
        //   titleMedium: TextStyle(
        //       fontFamily: 'Kanun',
        //       fontSize: 20,
        //       fontWeight: FontWeight.bold,
        //       color: Colors.black54),
        //   titleSmall: TextStyle(
        //       fontFamily: 'Kanun',
        //       fontSize: 16,
        //       fontWeight: FontWeight.bold,
        //       color: Colors.black54),

        //   // Body Styles

        //   bodyLarge: TextStyle(
        //     fontFamily: 'Kanun',
        //     fontSize: 18,
        //     color: Colors.black54,
        //   ),
        //   bodyMedium: TextStyle(
        //     fontFamily: 'Kanun',
        //     fontSize: 16,
        //     color: Colors.black54,
        //   ),
        //   bodySmall: TextStyle(
        //     fontFamily: 'Kanun',
        //     fontSize: 14,
        //     color: Colors.black54,
        //   ),

        //   // Label Styles
        //   labelLarge: TextStyle(
        //       fontFamily: 'Kanun',
        //       fontSize: 18,
        //       fontWeight: FontWeight.bold,
        //       color: Colors.black54),
        //   labelMedium: TextStyle(
        //       fontFamily: 'Kanun',
        //       fontSize: 16,
        //       fontWeight: FontWeight.bold,
        //       color: Colors.black54),
        //   labelSmall: TextStyle(
        //       fontFamily: 'Kanun',
        //       fontSize: 14,
        //       fontWeight: FontWeight.bold,
        //       color: Colors.black54),
        // ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: "/welcome_screen",
      routes: {
        // '/splash_screen': ((context) => const SplashScreen()),
        '/welcome_screen': ((context) => const WelcomeScreen()),
        '/customer_screen': ((context) => const CustomerHomeScrean()),
        '/supplier_screen': ((context) => const SupplierHomeScreen()),
        '/signup': ((context) => const RgisterScreen()),
        '/login': ((context) => const LogInScreen()),
      },
    );
  }
}
