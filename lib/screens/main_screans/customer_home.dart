import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:multi_store_app/screens/main_screans/cart.dart';
import 'package:multi_store_app/screens/main_screans/category.dart';
import 'package:multi_store_app/screens/main_screans/home.dart';
import 'package:multi_store_app/screens/main_screans/profile.dart';
import 'package:multi_store_app/screens/main_screans/stores.dart';

import '../../utilities/connectivity_service.dart';
import '../../widgets/internet_dialog.dart';

//I have created a fulstatwidget for customer page that have a navigationbar.
class CustomerHomeScrean extends StatefulWidget {
  const CustomerHomeScrean({
    super.key,
  });

  @override
  State<CustomerHomeScrean> createState() => _CustomerHomeScreanState();
}

class _CustomerHomeScreanState extends State<CustomerHomeScrean> {
  ConnectivityService connectivityService = ConnectivityService();
  int _selectedIndex = 0;
  final List<Widget> _tabs = const [
    HomeScrean(),
    CategoryScreen(),
    StoresScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  @override
  void dispose() {
    connectivityService.dispose();
    super.dispose();
  }

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
        body: StreamBuilder<dynamic>(
            stream: connectivityService!.connectivityStream,
            builder: (context, snapshot) {
              debugPrint(snapshot.data.toString());
              if (snapshot.hasData &&
                  snapshot.data == InternetConnectionStatus.connected) {
                return _tabs.elementAt(_selectedIndex);
              } else {
                return const InternetAlertDialog();
              }
            }),
      ),
    );
  }
}
