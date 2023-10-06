import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:multi_store_app/widgets/reuseable_bottun.dart';
import 'package:multi_store_app/widgets/snackbarr.dart';

// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

bool _passwordVisibalty = false;

String email = '';
String password = '';

class LogIn extends StatefulWidget {
  const LogIn({
    super.key,
  });

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> with WidgetsBindingObserver {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scafoldKey =
      GlobalKey<ScaffoldMessengerState>();

  bool _isKeyboardVisible = false;
  bool loginingIn = false;
  double keyboardHeight = 0;
  String customerOrSupplier = '';

  // CollectionReference customers =
  //     FirebaseFirestore.instance.collection('customers');
  // CollectionReference suppliers =
  //     FirebaseFirestore.instance.collection('suppliers');

  Future<String?> getSupOrcusByEmail(String email) async {
    try {
      // Query Firestore for the document with the specified email in the 'suppliers' collection
      QuerySnapshot supplierQuerySnapshot = await FirebaseFirestore.instance
          .collection('suppliers')
          .where('email', isEqualTo: email)
          .get();

      if (supplierQuerySnapshot.docs.isNotEmpty) {
        // Extract the 'supOrcus' property from the first document in the result
        var data = supplierQuerySnapshot.docs[0].data() as Map<String, dynamic>;
        return data['supOrcus'];
      }

      // If not found in 'suppliers', try to find the email in the 'customers' collection
      QuerySnapshot customerQuerySnapshot = await FirebaseFirestore.instance
          .collection('customers')
          .where('email', isEqualTo: email)
          .get();

      if (customerQuerySnapshot.docs.isNotEmpty) {
        // Extract the 'supOrcus' property from the first document in the result
        var data = customerQuerySnapshot.docs[0].data() as Map<String, dynamic>;
        return data['supOrcus'];
      }

      return null; // Email not found in either 'suppliers' or 'customers' collection
    } catch (error) {
      debugPrint("Error: $error");
      return null;
    }
  }

  Future<void> logIn() async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        String? cusOrSup = await getSupOrcusByEmail(email);
        if (cusOrSup == 'customer' && customerOrSupplier == 'customer') {
          await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password);
          _formKey.currentState!.reset();
          Navigator.pushReplacementNamed(context, '/customer_screen',
              arguments: 'customer');
        } else if (cusOrSup == 'supplier' && customerOrSupplier == 'supplier') {
          await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password);
          _formKey.currentState!.reset();
          Navigator.pushReplacementNamed(context, '/supplier_screen');
        } else {
          Snackbar(
                  key: _scafoldKey,
                  content: 'حساب ندارید ابتدا حساب ایجاد کنید !')
              .showsnackBar();
        }
      } else {
        Snackbar(key: _scafoldKey, content: 'ایمیل و پسورد خود را وارد کنید!')
            .showsnackBar();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Snackbar(
                key: _scafoldKey,
                content: 'حساب ندارید ابتدا حساب ایجاد کنید !')
            .showsnackBar();
      } else if (e.code == 'wrong-password') {
        Snackbar(key: _scafoldKey, content: 'پسورد خود را درست وارد کنید!')
            .showsnackBar();
      }
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
    keyboardHeight = WidgetsBinding.instance.window.viewInsets.bottom;
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
        child: Scaffold(
          bottomNavigationBar: AnimatedContainer(
            duration: const Duration(milliseconds: 0),
            padding: EdgeInsets.only(
                bottom: _isKeyboardVisible
                    ? MediaQuery.of(context).viewInsets.bottom
                    : 0),
            child: Row(
              children: [
                Expanded(
                  child: loginingIn
                      ? const Center(
                          child: CupertinoActivityIndicator(
                            radius: 30,
                          ),
                        )
                      : RawMaterialButton(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          fillColor: Colors.blue,
                          onPressed: () {
                            setState(() {
                              loginingIn = true;
                            });
                            logIn().whenComplete(() {
                              setState(() {
                                loginingIn = false;
                              });
                            });
                          },
                          child: const Text(
                            'وارد شدن',
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
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                arguments == 'customer' ? 'خریدار' : 'فروشنده',
                                style: const TextStyle(
                                    fontSize: 40, fontWeight: FontWeight.bold),
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
                        Column(
                          children: [
                            const TextFormFiled(
                              labelText: 'ایمیل',
                              hintText: 'ایمیل آدرس خود را وارد کنید',
                              textInputType: TextInputType.emailAddress,
                            ),
                            TextFormFiled(
                              labelText: 'پسورد ',
                              hintText: 'پسورد خود را وارد کنید',
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
                                'حساب ندارید؟',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              ReuseableButton(
                                child: const Text(
                                  'ثبت نام',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, '/signup',
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
      ),
    );
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
          if (textInputType == TextInputType.emailAddress) {
            email = value;
          } else {
            password = value;
          }
        },
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
