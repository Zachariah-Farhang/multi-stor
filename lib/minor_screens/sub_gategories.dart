import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SubGategories extends StatelessWidget {
  final String subcategName;
  const SubGategories({super.key, required this.subcategName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: const Icon(
              CupertinoIcons.back,
              color: Colors.black,
            ),
            onPressed: () => Navigator.of(context).pop()),
        title: Text(
          subcategName,
          style: const TextStyle(color: Colors.black87),
        ),
      ),
      body: const Center(
        child: Text('SubGategories'),
      ),
    );
  }
}
