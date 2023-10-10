import 'package:flutter/material.dart';

import 'package:multi_store_app/galleries/gallery.dart';

import '../../widgets/app_bar_back_button_widget.dart';

class SubGategories extends StatefulWidget {
  const SubGategories({
    super.key,
    required this.subcategName,
    required this.maincategName,
  });

  final String maincategName;
  final String subcategName;

  @override
  State<SubGategories> createState() => _SubGategoriesState();
}

class _SubGategoriesState extends State<SubGategories> {
  final GlobalKey<ScaffoldMessengerState> _scafoldKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScaffoldMessenger(
        key: _scafoldKey,
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
            scafoldKey: _scafoldKey,
          ),
        ),
      ),
    );
  }
}
