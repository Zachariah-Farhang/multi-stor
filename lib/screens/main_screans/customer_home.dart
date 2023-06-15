import 'package:flutter/material.dart';
import 'package:multi_store_app/screens/main_screans/cart.dart';
import 'package:multi_store_app/screens/main_screans/category.dart';
import 'package:multi_store_app/screens/main_screans/home.dart';
import 'package:multi_store_app/screens/main_screans/stores.dart';

//I have created a fulstatwidget for customer page that have a navigationbar.
class CustomerHomeScrean extends StatefulWidget {
  const CustomerHomeScrean({super.key});

  @override
  State<CustomerHomeScrean> createState() => _CustomerHomeScreanState();
}

class _CustomerHomeScreanState extends State<CustomerHomeScrean> {
  int _selectedIndex = 0;
  final List<Widget> _tabs = const [
    HomeScrean(),
    CategoryScreen(),
    StoresScreen(),
    CartScreen(),
    Center(child: Text('Profile')),
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
                icon: Icon(Icons.shopping_cart), label: 'سبدخرید'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'پروفایل'),
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
