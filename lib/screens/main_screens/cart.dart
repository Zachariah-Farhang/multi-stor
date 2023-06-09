import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../widgets/reuseable_bottun.dart';

class CartScreen extends StatefulWidget {
  final Widget? backButtom;
  const CartScreen({super.key, this.backButtom});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void replacePage() {
    Navigator.canPop(context)
        ? Navigator.pop(context)
        : Navigator.pushReplacementNamed(context, '/customer_screen');
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Material(
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.white,
              title: const Text(
                "سبدخرید",
                style: TextStyle(color: Colors.black87),
              ),
              leading: widget.backButtom,
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
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const AutoSizeText(
                      "سبدخرید شما خالی است !",
                      style: TextStyle(fontSize: 30),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    ReuseableButton(
                      onPressed: replacePage,
                      color: Colors.blueAccent,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "به خرید ادامه دهید",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    )
                  ]),
            ),
            bottomSheet: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
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
                        color: Colors.yellow,
                        child: const Text("پرداخت",
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 22,
                                fontWeight: FontWeight.bold)))
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
