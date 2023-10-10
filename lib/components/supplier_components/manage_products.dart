import 'package:flutter/material.dart';
import 'package:multi_store_app/widgets/app_bar_back_button_widget.dart';

class ManageProducts extends StatelessWidget {
  const ManageProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'مدریت سفارشات',
          style: TextStyle(
            color: Colors.black87,
          ),
        ),
        leading: const AppBarBackButton(color: Colors.black87),
      ),
    );
  }
}
