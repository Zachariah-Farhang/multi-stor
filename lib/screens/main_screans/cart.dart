import 'dart:ffi';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_app/screens/main_screans/customer_home.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void replacePage() {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const CustomerHomeScrean()));
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          title: const Text(
            "سبدخرید",
            style: TextStyle(color: Colors.black87),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.delete_forever,
                  color: Colors.black87,
                ))
          ],
        ),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const AutoSizeText(
              "سبدخرید شما خالی است !",
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(
              height: 50,
            ),
            ReuseableButton(
              onPressed: replacePage,
              text: const Text(
                "به خرید ادامه دهید",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              color: Colors.blueAccent,
            )
          ]),
        ),
        bottomSheet: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Row(
              children: [
                Text(
                  "مجموعه :",
                  style: TextStyle(fontSize: 22),
                ),
                Text(
                  " \$۲۳,۳۰",
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            ReuseableButton(
                onPressed: () {},
                text: const Text("پرداخت",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 22,
                        fontWeight: FontWeight.bold)),
                color: Colors.yellow)
          ]),
        ),
      ),
    );
  }
}

class ReuseableButton extends StatelessWidget {
  final void Function() onPressed;
  final Text text;
  final Color color;
  const ReuseableButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(color),
        elevation: MaterialStateProperty.all(0),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(16.0), // Adjust the value as needed
          ),
        ),
      ),
      onPressed: onPressed,
      child: text,
    );
  }
}
