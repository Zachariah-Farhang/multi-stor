import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_store_app/auth/auth_components.dart';
import 'package:multi_store_app/widgets/reuseable_bottun.dart';
import 'package:multi_store_app/widgets/snackbarr.dart';

import '../widgets/reuseable_continer.dart';

bool _passwordVisibalty = false;

String name = '';
String email = '';
String password = '';

class CustomerRgisterScreen extends StatefulWidget {
  const CustomerRgisterScreen({super.key});

  @override
  State<CustomerRgisterScreen> createState() => _CustomerRgisterScreenState();
}

class _CustomerRgisterScreenState extends State<CustomerRgisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scafoldKey =
      GlobalKey<ScaffoldMessengerState>();
  XFile? _imageFile;
  dynamic _pickedImageError;

  void _pickImageFromCamera() async {
    try {
      final pickedImaae = await ImagePicker().pickImage(
          source: ImageSource.camera,
          maxHeight: 300,
          maxWidth: 300,
          imageQuality: 95);
      setState(() {
        _imageFile = pickedImaae;
      });
    } catch (e) {
      setState(() {
        _pickedImageError = e;
      });
      debugPrint(_pickedImageError);
    }
  }

  void _pickImageFromGallery() async {
    try {
      final pickedImaae = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          maxHeight: 300,
          maxWidth: 300,
          imageQuality: 95);
      setState(() {
        _imageFile = pickedImaae;
      });
    } catch (e) {
      setState(() {
        _pickedImageError = e;
      });
      debugPrint(_pickedImageError);
    }
  }

  void signUp() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        Navigator.pushReplacementNamed(context, '/customer_screen');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          Snackbar(_scafoldKey, 'این ایمیل قبلا استفاده شده!').showsnackBar();
        }
      }
    } else {
      Snackbar(_scafoldKey, 'لطفا همه فورمها را خانه پری نمایید!')
          .showsnackBar();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScaffoldMessenger(
        key: _scafoldKey,
        child: Scaffold(
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                reverse: true,
                physics: const BouncingScrollPhysics(),
                child: Form(
                  key: _formKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'ثبت نام',
                                style: TextStyle(
                                    fontSize: 40, fontWeight: FontWeight.bold),
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
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              child: CircleAvatar(
                                radius: 60,
                                backgroundColor: Colors.amber,
                                backgroundImage: _imageFile == null
                                    ? null
                                    : FileImage(File(_imageFile!.path)),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ReusableCotiner(
                                  onPressed: () {
                                    _pickImageFromCamera();
                                  },
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
                                  onPressed: () {
                                    _pickImageFromGallery();
                                  },
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
                        Column(
                          children: [
                            const TextFormFiled(
                              labelText: 'نام ',
                              hintText: 'نام و تخلص خود را وارد کنید',
                              textInputType: TextInputType.text,
                            ),
                            const TextFormFiled(
                              labelText: 'ایمیل',
                              hintText: ' ایمیل آدرس',
                              textInputType: TextInputType.emailAddress,
                            ),
                            TextFormFiled(
                              labelText: 'پسورد ',
                              hintText: 'پسورد',
                              textInputType: TextInputType.visiblePassword,
                              onPressed: () {
                                setState(() {
                                  _passwordVisibalty = !_passwordVisibalty;
                                });
                              },
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
                                  onPressed: () {
                                    signUp();
                                  },
                                  child: const Text(
                                    'ثبت نام',
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
  final void Function()? onPressed;
  const TextFormFiled(
      {super.key,
      required this.labelText,
      required this.hintText,
      required this.textInputType,
      this.onPressed});

  String? validateValue(String value, TextInputType textInputType) {
    if (value.isEmpty && textInputType == TextInputType.text) {
      return 'لطفا نام و تخلص خود را وارد کنید!';
    } else if (value.isEmpty && textInputType == TextInputType.emailAddress) {
      return 'لطفا ایمیل خود را وارد کنید!';
    } else if (value.isNotEmpty &&
        textInputType == TextInputType.emailAddress &&
        value.isValidEmail() == false) {
      return 'لطفا ایمیل خود را درست وارد کنید!';
    } else if (value.isEmpty &&
        textInputType == TextInputType.visiblePassword) {
      return 'لطفا پسورد را وارد کنید!';
    } else if (value.isNotEmpty &&
        textInputType == TextInputType.visiblePassword &&
        value.isValidPassword() == false) {
      return 'پسورد باید حداقل شش حرف مشتکل ازاعدادوحروف باشد';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: TextFormField(
        onChanged: (value) {
          if (textInputType == TextInputType.text) {
            name = value;
          } else if (textInputType == TextInputType.emailAddress) {
            email = value;
          } else {
            password = value;
          }
        },
        validator: (value) => validateValue(value!, textInputType),
        obscureText: textInputType == TextInputType.visiblePassword
            ? _passwordVisibalty
            : false,
        keyboardType: textInputType,
        decoration: InputDecoration(
          suffixIcon: textInputType == TextInputType.visiblePassword
              ? IconButton(
                  onPressed: onPressed,
                  icon: Icon(
                    _passwordVisibalty
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ))
              : null,
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
            borderSide:
                const BorderSide(color: Colors.deepPurpleAccent, width: 2),
            borderRadius: BorderRadius.circular(25),
          ),
        ),
      ),
    );
  }
}
