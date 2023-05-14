import 'package:flutter/material.dart';

import 'main_screans/customer_home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  //This widget is the root of ouer application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      //This widget is the main screan that is showing now on the app CustomerHomeScrean().
      home: CustomerHomeScrean(),
    );
  }
}
