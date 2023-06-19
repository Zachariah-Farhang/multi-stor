import 'package:flutter/material.dart';
import 'package:multi_store_app/widgets/reuseable_bottun.dart';

import '../widgets/reuseable_continer.dart';

class CustomerRgisterScreen extends StatefulWidget {
  const CustomerRgisterScreen({super.key});

  @override
  State<CustomerRgisterScreen> createState() => _CustomerRgisterScreenState();
}

class _CustomerRgisterScreenState extends State<CustomerRgisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            reverse: true,
            physics: const BouncingScrollPhysics(),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'ثبت نام',
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, '/welcome_screen');
                      },
                      icon: const Icon(
                        Icons.home_work,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.amber,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ReusableCotiner(
                        onPressed: () {},
                        decoration: const BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15)),
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                        ),
                      ),
                      ReusableCotiner(
                        onPressed: () {},
                        decoration: const BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15)),
                        ),
                        child: const Icon(
                          Icons.photo,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const Column(
                children: [
                  TextFormFiled(
                    labelText: 'نام ',
                    hintText: 'نام کامل خود را وارد کنید',
                    textInputType: TextInputType.text,
                  ),
                  TextFormFiled(
                    labelText: 'ایمیل',
                    hintText: 'ایمیل آدرس',
                    textInputType: TextInputType.emailAddress,
                  ),
                  TextFormFiled(
                    labelText: 'پسورد ',
                    hintText: 'پسورد',
                    textInputType: TextInputType.visiblePassword,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      'قبلا ثبت نام کردید؟',
                      style: TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    ReuseableButton(
                      child: const Text(
                        'وارد شوید',
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      onPressed: () {},
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ReuseableButton(
                        color: Colors.blue,
                        onPressed: () {},
                        child: const Text(
                          'وارد شوید',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 24),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}

class TextFormFiled extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextInputType textInputType;
  const TextFormFiled({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.textInputType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: TextFormField(
        keyboardType: textInputType,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.purple, width: 1),
            borderRadius: BorderRadius.circular(25),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.deepPurpleAccent, width: 2),
            borderRadius: BorderRadius.circular(25),
          ),
        ),
      ),
    );
  }
}
