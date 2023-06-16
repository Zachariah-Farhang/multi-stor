import 'package:flutter/material.dart';
import 'package:multi_store_app/widgets/reuseable_bottun.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
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
                  const Text(
                    "خوش آمدید",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: 120,
                    width: 200,
                    child: Image(
                        image: AssetImage("assets/images/tabImages/bags.png")),
                  ),
                  const Text(
                    "فروشگاه",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Column(
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
                              children: [
                                ReuseableButton(
                                  color: Colors.amber,
                                  onPressed: () {},
                                  child: const Text(
                                    "وارد شدن",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
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
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const Image(
                                    height: 50,
                                    image: AssetImage(
                                        "assets/images/tabImages/bags.png"))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
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
                                const Image(
                                    height: 50,
                                    image: AssetImage(
                                        "assets/images/tabImages/bags.png")),
                                ReuseableButton(
                                  color: Colors.amber,
                                  onPressed: () {},
                                  child: const Text(
                                    "وارد شدن",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
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
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    color: Colors.grey.withOpacity(0.6),
                    height: 80,
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: 40,
                              width: 40,
                              child: Image(
                                image: AssetImage(
                                    "assets/images/welcome/google.png"),
                              ),
                            ),
                            Text(
                              "گوگل",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 40,
                              width: 40,
                              child: Image(
                                image: AssetImage(
                                    "assets/images/welcome/facebook.png"),
                              ),
                            ),
                            Text(
                              "فیسبوک",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 40,
                              width: 40,
                              child: Image(
                                image:
                                    AssetImage("assets/images/welcome/man.png"),
                              ),
                            ),
                            Text(
                              "مهمان",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            )
                          ],
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
