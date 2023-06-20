import 'package:flutter/material.dart';

import '../../widgets/app_bar_back_button.dart';

class SubGategories extends StatelessWidget {
  final String subcategName;
  final String maincategName;

  const SubGategories(
      {super.key, required this.subcategName, required this.maincategName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: const AppBarBackButton(),
        title: Text(
          subcategName,
          style: const TextStyle(color: Colors.black87),
        ),
      ),
      body: Center(
        child: Text(maincategName),
      ),
    );
  }
}
