import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:multi_store_app/widgets/reuseable_bottun.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../utilities/netwotk_checker.dart';
import '../../widgets/login_bottun.dart';

const colorizeColors = [
  Colors.amber,
  Colors.blue,
  Colors.yellow,
  Colors.red,
  Colors.green,
  Colors.amber,
];

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool isProcessing = false;
  bool hasInternet = false;
  // Stream<ConnectivityResult> internetStatusChange =
  //     Connectivity().onConnectivityChanged;

  Map _source = {ConnectivityResult.none: false};
  final NetworkConnectivity _networkConnectivity = NetworkConnectivity.instance;
  String string = '';

  @override
  void initState() {
    super.initState();
    requestPermissions();
    checkConectivity();
    _networkConnectivity.initialise();
    _networkConnectivity.myStream.listen((source) {
      _source = source;

      switch (_source.keys.toList()[0]) {
        case ConnectivityResult.mobile:
          string =
              _source.values.toList()[0] ? 'Mobile: Online' : 'Mobile: Offline';
          break;
        case ConnectivityResult.wifi:
          string =
              _source.values.toList()[0] ? 'WiFi: Online' : 'WiFi: Offline';
          break;
        case ConnectivityResult.none:
        default:
          string = 'Offline';
      }
      // 2.
      if (mounted) {
        setState(() {
          if (string == 'Mobile: Online' || string == 'WiFi: Online') {
            hasInternet = true;
            isProcessing = false;
          } else {
            isProcessing = true;
          }
        });
      }

      // 3.
    });
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

    // Request photo library permission
    final photoLibraryStatus = await Permission.photos.request();
    if (photoLibraryStatus.isDenied) {
      // Photo library permission denied
      return false;
    }

    // Request internet permission
    // final internetStatus = await Permission.internet.request();
    // if (internetStatus.isDenied) {
    //   // Internet permission denied
    //   return false;
    // }

    // All permissions granted
    return true;
  }

  Future<bool> checkConectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      // Internet is available
      setState(() {
        hasInternet = true;
      });
    } else {
      // No internet connection
      setState(() {
        hasInternet = false;
      });
    }
    return hasInternet;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/images/welcome/welcamback.jpg"),
            ),
          ),
          child: SafeArea(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 70,
                        decoration: BoxDecoration(
                            color: Colors.black87.withOpacity(0.4),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15))),
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.26),
                        child: AnimatedTextKit(
                            repeatForever: true,
                            animatedTexts: [
                              ColorizeAnimatedText(
                                "دیوار هرات",
                                textAlign: TextAlign.right,
                                textStyle: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.12,
                                  fontWeight: FontWeight.bold,
                                ),
                                colors: colorizeColors,
                              ),
                            ]),
                      ),
                    ],
                  ),
                  const SuplierSignInOrSignUp(),
                  const BuyerSignInOrSignUp(),
                  Container(
                    color: Colors.grey.withOpacity(0.6),
                    height: 80,
                    child: Row(
                      children: [
                        LoginBottom(
                          onTop: () {},
                          text: "گوگل",
                          imagePath: "assets/images/welcome/google.png",
                        ),
                        LoginBottom(
                          onTop: () {},
                          text: "فیسبوک",
                          imagePath: "assets/images/welcome/facebook.png",
                        ),
                        isProcessing
                            ? const Expanded(
                                child:
                                    Center(child: CircularProgressIndicator()))
                            : LoginBottom(
                                onTop: () async {
                                  await checkConectivity();
                                  setState(() {
                                    isProcessing = true;
                                  });
                                  if (hasInternet) {
                                    await FirebaseAuth.instance
                                        .signInAnonymously()
                                        .whenComplete(() {
                                      Navigator.pushReplacementNamed(
                                          context, '/customer_screen');
                                    });
                                  }
                                },
                                text: "مهمان",
                                imagePath: "assets/images/welcome/man.png",
                              )
                      ],
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}

class BuyerSignInOrSignUp extends StatelessWidget {
  const BuyerSignInOrSignUp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.6),
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(30),
                  bottomRight: Radius.circular(30))),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              "خریدار",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.6),
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
              child: Row(
                children: [
                  ReuseableButton(
                    color: Colors.amber,
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/login',
                          arguments: 'customer');
                    },
                    child: const Text(
                      "وارد شدن",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  ReuseableButton(
                    color: Colors.amber,
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                        context,
                        '/signup',
                        arguments: 'customer',
                      );
                    },
                    child: const Text(
                      "ثبت نام",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class SuplierSignInOrSignUp extends StatelessWidget {
  const SuplierSignInOrSignUp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.6),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomLeft: Radius.circular(30))),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              "فروشنده",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.6),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomLeft: Radius.circular(30))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ReuseableButton(
                    color: Colors.amber,
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/login',
                          arguments: 'supplier');
                    },
                    child: const Text(
                      "وارد شدن",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  ReuseableButton(
                    color: Colors.amber,
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                        context,
                        '/signup',
                        arguments: 'supplier',
                      );
                    },
                    child: const Text(
                      "ثبت نام",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
