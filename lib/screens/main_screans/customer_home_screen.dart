import 'package:flutter/material.dart';

import 'package:multi_store_app/screens/main_screans/cart.dart';
import 'package:multi_store_app/screens/main_screans/category.dart';
import 'package:multi_store_app/screens/main_screans/home.dart';
import 'package:multi_store_app/screens/main_screans/profile.dart';
import 'package:multi_store_app/screens/main_screans/stores.dart';

//I have created a fulstatwidget for customer page that have a navigationbar.
class CustomerHomeScrean extends StatefulWidget {
  const CustomerHomeScrean({
    super.key,
  });

  @override
  State<CustomerHomeScrean> createState() => _CustomerHomeScreanState();
}

class _CustomerHomeScreanState extends State<CustomerHomeScrean> {
  int _selectedIndex = 0;
  List<Widget> tabs = [];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Scaffold is the root widget of the customer page.
    String arguments = ModalRoute.of(context)!.settings.arguments.toString();

    tabs = [
      const HomeScrean(),
      const CategoryScreen(),
      const StoresScreen(),
      const CartScreen(),
      ProfileScreen(
        userTyope: arguments,
      ),
    ];
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
        body: tabs.elementAt(_selectedIndex),
      ),
    );
  }
}
