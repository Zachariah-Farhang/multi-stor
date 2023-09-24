import 'package:flutter/material.dart';

import 'package:multi_store_app/galleries/gallery.dart';

import '../../widgets/app_bar_back_button.dart';

class SubGategories extends StatefulWidget {
  final String subcategName;
  final String maincategName;

  const SubGategories(
      {super.key, required this.subcategName, required this.maincategName});

  @override
  State<SubGategories> createState() => _SubGategoriesState();
}

class _SubGategoriesState extends State<SubGategories> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.white,
          leading: const AppBarBackButton(
            color: Colors.black87,
          ),
          title: Text(
            widget.subcategName,
            style: const TextStyle(color: Colors.black87),
          ),
        ),
        body: GalleryScreen(
          category: widget.maincategName,
          subCategory: widget.subcategName,
        ),
      ),
    );
  }
}
