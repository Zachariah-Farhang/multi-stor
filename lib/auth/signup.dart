import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_store_app/utilities/auth_utils.dart';
import 'package:multi_store_app/widgets/reuseable_bottun.dart';
import 'package:multi_store_app/widgets/snackbarr_widget.dart';
import 'package:provider/provider.dart';

import '../providers/internet_provider.dart';
import '../widgets/no_internet_widget.dart';
import '../utilities/global_values.dart';

// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

bool _passwordVisibalty = false;
bool signingInUp = false;
String name = '';
String email = '';
String password = '';
String phoneNumber = '';
String address = '';

class RgisterScreen extends StatefulWidget {
  const RgisterScreen({
    super.key,
  });

  @override
  State<RgisterScreen> createState() => _RgisterScreenState();
}

class _RgisterScreenState extends State<RgisterScreen>
    with WidgetsBindingObserver {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scafoldKey =
      GlobalKey<ScaffoldMessengerState>();
  XFile? _imageFile;
  dynamic _pickedImageError;
  bool _isKeyboardVisible = false;
  double keyboardHeight = 0;
  String customerOrSupplier = '';

  late String profileImage;
  late String uid;
  CollectionReference customers =
      FirebaseFirestore.instance.collection('customers');
  CollectionReference suppliers =
      FirebaseFirestore.instance.collection('suppliers');

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
          imageQuality: 100);
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

  Future<void> signUp() async {
    if (_formKey.currentState!.validate() && _imageFile != null) {
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        if (customerOrSupplier.isNotEmpty && customerOrSupplier == 'customer') {
          Reference ref =
              FirebaseStorage.instance.ref('cust-images/$email.jpg');
          await ref.putFile(File(_imageFile!.path));

          profileImage = await ref.getDownloadURL();
          uid = FirebaseAuth.instance.currentUser!.uid;
          customers.doc(uid).set({
            'name': name,
            'email': email,
            'profileImage': profileImage,
            'phone': phoneNumber,
            'address': address,
            'cid': uid,
            'supOrcus': customerOrSupplier
          });
          Future.delayed(const Duration(microseconds: 100))
              .whenComplete(() => Navigator.pushReplacementNamed(
                    context,
                    '/customer_screen',
                  ));

          GlobalValues().userType = 'customer';
        } else {
          Reference ref =
              FirebaseStorage.instance.ref('supl-images/$email.jpg');
          await ref.putFile(File(_imageFile!.path));

          profileImage = await ref.getDownloadURL();
          uid = FirebaseAuth.instance.currentUser!.uid;
          suppliers.doc(uid).set({
            'storeName': name,
            'email': email,
            'profileImage': profileImage,
            'phone': phoneNumber,
            'address': address,
            'sid': uid,
            'supOrcus': customerOrSupplier
          });

          Future.delayed(const Duration(microseconds: 100)).whenComplete(() =>
              Navigator.pushReplacementNamed(context, '/supplier_screen'));
          GlobalValues().userType = 'supplier';
        }

        _formKey.currentState!.reset();
        setState(() {
          _imageFile = null;
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          Snackbar(key: _scafoldKey, content: 'این ایمیل قبلا استفاده شده!')
              .showsnackBar();
        }
      }
    } else if (_formKey.currentState!.validate() && _imageFile == null) {
      Snackbar(
              key: _scafoldKey, content: 'لطفا عکس پروفایل خود را انتخاب کنید!')
          .showsnackBar();
    } else {
      Snackbar(key: _scafoldKey, content: 'لطفا همه بخش ها را خانه پری نمایید!')
          .showsnackBar();
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    keyboardHeight = View.of(context).viewInsets.bottom;
    setState(() {
      _isKeyboardVisible = keyboardHeight > 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as String;
    customerOrSupplier = arguments;
    return Directionality(
        textDirection: TextDirection.rtl,
        child: ScaffoldMessenger(
            key: _scafoldKey,
            child: Consumer<ConnectivityProvider>(
                builder: (context, connection, child) {
              return Stack(
                children: [
                  Scaffold(
                    bottomNavigationBar: AnimatedContainer(
                      duration: const Duration(milliseconds: 0),
                      padding: EdgeInsets.only(
                          bottom: _isKeyboardVisible
                              ? MediaQuery.of(context).viewInsets.bottom
                              : 0),
                      child: Row(
                        children: [
                          Expanded(
                            child: signingInUp
                                ? const Material(
                                    child: Center(
                                      child: CupertinoActivityIndicator(
                                        radius: 30,
                                      ),
                                    ),
                                  )
                                : RawMaterialButton(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 4),
                                    fillColor: Colors.blue,
                                    onPressed: () {
                                      FocusScope.of(context).unfocus();
                                      setState(() {
                                        signingInUp = true;
                                      });
                                      signUp().whenComplete(() {
                                        setState(() {
                                          signingInUp = false;
                                        });
                                      });
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
                    ),
                    body: SafeArea(
                      child: Center(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Form(
                            key: _formKey,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          arguments == 'customer'
                                              ? 'خریدار'
                                              : 'فروشنده',
                                          style: const TextStyle(
                                              fontSize: 40,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            FocusScope.of(context).unfocus();
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
                                              : FileImage(
                                                  File(_imageFile!.path)),
                                          child: arguments == 'customer' &&
                                                  _imageFile == null
                                              ? const Padding(
                                                  padding: EdgeInsets.all(4.0),
                                                  child: Text(
                                                    "تصویر پروفایل خود را انتخاب کنید",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w900),
                                                  ),
                                                )
                                              : arguments == 'supplier' &&
                                                      _imageFile == null
                                                  ? const Padding(
                                                      padding:
                                                          EdgeInsets.all(4.0),
                                                      child: Text(
                                                        "لوگوی فروشگاه خود را انتخاب کنید",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w900),
                                                      ),
                                                    )
                                                  : null,
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          PickImage(
                                              border: const BorderRadius.only(
                                                  topLeft: Radius.circular(12),
                                                  topRight:
                                                      Radius.circular(12)),
                                              icon: Icons.camera_alt,
                                              onPressed: () {
                                                _pickImageFromCamera();
                                              }),
                                          PickImage(
                                              border: const BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(12),
                                                  bottomRight:
                                                      Radius.circular(12)),
                                              icon: Icons.photo,
                                              onPressed: () {
                                                _pickImageFromGallery();
                                              }),
                                        ],
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      TextFormFiled(
                                        labelText: arguments == 'customer'
                                            ? 'نام '
                                            : ' نام فروشگاه',
                                        hintText: arguments == 'customer'
                                            ? 'نام و تخلص خود را وارد کنید'
                                            : 'نام فروشگاه خود را وارد کنید',
                                        textInputType: TextInputType.text,
                                      ),
                                      const TextFormFiled(
                                        labelText: 'شماره تماس',
                                        hintText: 'شماره تماس خود را وارد کنید',
                                        textInputType: TextInputType.phone,
                                      ),
                                      const TextFormFiled(
                                        labelText: 'ایمیل',
                                        hintText: 'ایمیل آدرس خود را وارد کنید',
                                        textInputType:
                                            TextInputType.emailAddress,
                                      ),
                                      const TextFormFiled(
                                        labelText: 'آدرس ',
                                        hintText: 'آدرس خود را وارد کنید',
                                        textInputType:
                                            TextInputType.streetAddress,
                                      ),
                                      TextFormFiled(
                                        labelText: 'پسورد ',
                                        hintText: 'پسورد خود را وارد کنید',
                                        textInputType:
                                            TextInputType.visiblePassword,
                                        onPressed: () {
                                          setState(() {
                                            _passwordVisibalty =
                                                !_passwordVisibalty;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
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
                                          onPressed: () {
                                            Navigator.pushReplacementNamed(
                                                context, '/login',
                                                arguments: customerOrSupplier);
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (!connection.isInternetStable)
                    NoInternetScreen(context: context).showModel()
                ],
              );
            })));
  }
}

class PickImage extends StatelessWidget {
  const PickImage(
      {super.key,
      required this.onPressed,
      required this.icon,
      required this.border});
  final void Function() onPressed;
  final IconData icon;
  final BorderRadius border;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.purple, borderRadius: border),
      constraints: const BoxConstraints(minWidth: double.minPositive),
      child: IconButton(
        splashRadius: 2,
        constraints: const BoxConstraints(minHeight: 40, minWidth: 40),
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: Colors.white,
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
    } else if (value.isEmpty && textInputType == TextInputType.number) {
      return 'لطفا شماره تماس خود را وارد کنید!';
    } else if (value.isEmpty && textInputType == TextInputType.streetAddress) {
      return 'لطفا آدرس خود را وارد کنید!';
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
        buildCounter: (context,
                {required currentLength, required isFocused, maxLength}) =>
            Text(currentLength.toString()),
        textAlignVertical: TextAlignVertical.bottom,
        onChanged: (value) {
          if (textInputType == TextInputType.text) {
            name = value;
          } else if (textInputType == TextInputType.emailAddress) {
            email = value;
          } else if (textInputType == TextInputType.phone) {
            phoneNumber = value;
          } else if (textInputType == TextInputType.streetAddress) {
            address = value;
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
          constraints: const BoxConstraints(maxHeight: 80),
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
            borderRadius: BorderRadius.circular(16),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.purple, width: 1),
            borderRadius: BorderRadius.circular(16),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: Colors.deepPurpleAccent, width: 1),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}
