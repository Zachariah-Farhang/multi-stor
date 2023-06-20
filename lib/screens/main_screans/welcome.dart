import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:multi_store_app/widgets/reuseable_bottun.dart';

import '../../widgets/login_bottun.dart';

const colorizeColors = [
  Colors.orangeAccent,
  Colors.blue,
  Colors.yellow,
  Colors.red,
  Colors.green,
  Colors.orange,
  Colors.pink,
];

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controler;
  @override
  void initState() {
    _controler =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _controler.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controler.dispose();
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
                  AnimatedTextKit(
                    isRepeatingAnimation: true,
                    repeatForever: true,
                    animatedTexts: [
                      ColorizeAnimatedText(
                        "خوش آمدید",
                        textStyle: const TextStyle(
                          fontSize: 45,
                          fontWeight: FontWeight.bold,
                        ),
                        colors: colorizeColors,
                      ),
                      ColorizeAnimatedText(
                        "به",
                        textStyle: const TextStyle(
                          fontSize: 45,
                          fontWeight: FontWeight.bold,
                        ),
                        colors: colorizeColors,
                      ),
                      ColorizeAnimatedText(
                        "دیوار هرات",
                        textStyle: const TextStyle(
                          fontSize: 45,
                          fontWeight: FontWeight.bold,
                        ),
                        colors: colorizeColors,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedTextKit(
                          repeatForever: true,
                          animatedTexts: [
                            RotateAnimatedText(
                              "خرید",
                              textStyle: const TextStyle(
                                  fontSize: 45,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange),
                            ),
                            RotateAnimatedText(
                              "فروش",
                              textStyle: const TextStyle(
                                  fontSize: 45,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange),
                            ),
                            RotateAnimatedText(
                              "بدون واسطه",
                              textStyle: const TextStyle(
                                  fontSize: 45,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange),
                            ),
                          ],
                        ),
                        AnimatedTextKit(repeatForever: true, animatedTexts: [
                          ColorizeAnimatedText(
                            "دیوار هرات",
                            textAlign: TextAlign.right,
                            textStyle: const TextStyle(
                              fontSize: 45,
                              fontWeight: FontWeight.bold,
                            ),
                            colors: colorizeColors,
                          ),
                        ]),
                      ],
                    ),
                  ),
                  SuplierSignInOrSignUp(controler: _controler),
                  BuyerSignInOrSignUp(controler: _controler),
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
                        LoginBottom(
                          onTop: () async {
                            await FirebaseAuth.instance.signInAnonymously();
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
    required AnimationController controler,
  }) : _controler = controler;

  final AnimationController _controler;

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
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.6),
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
              child: Row(
                children: [
                  AnimatedLogo(controler: _controler),
                  ReuseableButton(
                    color: Colors.amber,
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, '/customer_screen');
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
                          context, '/customer_signup');
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
    required AnimationController controler,
  }) : _controler = controler;

  final AnimationController _controler;

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
              padding: const EdgeInsets.symmetric(horizontal: 8),
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
                      Navigator.pushReplacementNamed(
                          context, '/supplier_screen');
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
                    onPressed: () {},
                    child: const Text(
                      "ثبت نام",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  AnimatedLogo(controler: _controler)
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class AnimatedLogo extends StatelessWidget {
  const AnimatedLogo({
    super.key,
    required AnimationController controler,
  }) : _controler = controler;

  final AnimationController _controler;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controler.view,
      builder: (context, child) {
        return Transform.rotate(
          angle: _controler.value * 2 * pi,
          child: child,
        );
      },
      child: const Image(
          height: 50, image: AssetImage("assets/images/tabImages/bags.png")),
    );
  }
}
