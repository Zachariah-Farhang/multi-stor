import 'package:flutter/material.dart';
import 'package:multi_store_app/screens/main_screens/category.dart';
import 'package:multi_store_app/screens/main_screens/dashboard.dart';
import 'package:multi_store_app/screens/main_screens/home.dart';

import 'package:multi_store_app/screens/main_screens/stores.dart';

//I have created a fulstatwidget for customer page that have a navigationbar.
class SupplierHomeScreen extends StatefulWidget {
  const SupplierHomeScreen({super.key});

  @override
  State<SupplierHomeScreen> createState() => _SupplierHomeScreenState();
}

class _SupplierHomeScreenState extends State<SupplierHomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> _tabs = const [
    HomeScrean(),
    CategoryScreen(),
    StoresScreen(),
    DashbordScreen(),
    Center(
      child: Text("افزودن جنس جدید"),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    //Scaffold is the root widget of the customer page.
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.blueGrey.shade700,
          // unselectedItemColor: Colors.red,
          currentIndex: _selectedIndex,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'خانه'),
            BottomNavigationBarItem(
                icon: Icon(Icons.search), label: 'دسته بندی'),
            BottomNavigationBarItem(icon: Icon(Icons.shop), label: 'فروشگاها'),
            BottomNavigationBarItem(
                icon: Icon(Icons.dashboard), label: 'داشبورد'),
            BottomNavigationBarItem(
                icon: Icon(Icons.upload), label: 'بارگذاری'),
          ],
          onTap: (index) {
            setState(
              () {
                _selectedIndex = index;
              },
            );
          },
        ),
        body: _tabs.elementAt(_selectedIndex),
      ),
    );
  }
}
