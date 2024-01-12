import 'dart:math';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_app/providers/internet_provider.dart';
import 'package:multi_store_app/widgets/no_internet_widget.dart';
import 'package:multi_store_app/widgets/reuseable_bottun.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../widgets/login_bottun_widget.dart';

const colorizeColors = [
  Colors.amber,
  Colors.blue,
  Colors.yellow,
  Colors.red,
  Colors.green,
  Colors.amber,
];

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({
    super.key,
  });

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  CollectionReference anonymous =
      FirebaseFirestore.instance.collection('anonymous');
  bool isFirst = false;
  bool isLoding = true;
  bool isSingingUp = false;
  Image myImage = Image.asset("assets/images/welcome/welcamback.jpg");
  String string = '';

  @override
  void didChangeDependencies() {
    precacheImage(myImage.image, context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    delayedTask();
    requestPermissions();
    super.initState();
  }

  void delayedTask() async {
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          isLoding = false;
        });
      }
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
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectivityProvider>(
      builder: (context, connection, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            body: Stack(
              children: [
                Container(
                  constraints: const BoxConstraints.expand(),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        isAntiAlias: true,
                        image: myImage.image),
                  ),
                  child: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.black87.withOpacity(0.4),
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15))),
                              margin: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height *
                                      0.26),
                              child: AnimatedTextKit(
                                  repeatForever: true,
                                  animatedTexts: [
                                    ColorizeAnimatedText(
                                      "دیوار هرات",
                                      textAlign: TextAlign.right,
                                      textStyle: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.12,
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
                            margin: const EdgeInsets.all(8),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(16)),
                            child: isSingingUp
                                ? const Expanded(
                                    child: Center(
                                        child: CupertinoActivityIndicator(
                                      radius: 18,
                                      color: Colors.amber,
                                    )),
                                  )
                                : LoginBottom(
                                    onTop: () async {
                                      setState(() {
                                        isSingingUp = true;
                                      });
                                      await FirebaseAuth.instance
                                          .signInAnonymously()
                                          .whenComplete(() {
                                        String defultName = 'User';
                                        int id = Random(100000000)
                                            .nextInt(100000000);

                                        String defultUserName =
                                            defultName + id.toString();
                                        late String uid;
                                        String phoneNumber = '';
                                        String email = '';
                                        String address = '';
                                        String userName = '';
                                        userName = defultUserName;
                                        email = '$defultUserName@gmail.com';
                                        address = defultUserName;
                                        phoneNumber = id.toString();

                                        uid = FirebaseAuth
                                            .instance.currentUser!.uid;
                                        anonymous.doc(uid).set({
                                          'name': userName,
                                          'email': email,
                                          'phone': phoneNumber,
                                          'address': address,
                                          'cid': uid,
                                        });
                                        Navigator.pushReplacementNamed(
                                            context, '/customer_screen',
                                            arguments: 'anonymous');
                                      });
                                    },
                                    text: "وارد شدن به عنوان مهمان",
                                    imagePath: "assets/images/welcome/man.png",
                                  )),
                      ],
                    ),
                  ),
                ),
                if (!connection.isInternetStable)
                  NoInternetScreen(context: context).showModel()
              ],
            ),
          ),
        );
      },
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
