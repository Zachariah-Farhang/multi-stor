import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/internet_provider.dart';
import 'category.dart';
import 'dashboard.dart';
import 'home.dart';

import '../../widgets/no_internet_widget.dart';
import 'stores.dart';

import 'uplode_product.dart';

//I have created a fulstatwidget for customer page that have a navigationbar.
class SupplierHomeScreen extends StatefulWidget {
  const SupplierHomeScreen({
    super.key,
  });

  @override
  State<SupplierHomeScreen> createState() => _SupplierHomeScreenState();
}

class _SupplierHomeScreenState extends State<SupplierHomeScreen> {
  int _selectedIndex = 0;
  List<Widget>? _tabs;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Scaffold is the root widget of the customer page.
    _tabs = [
      const HomeScrean(),
      const CategoryScreen(),
      const StoresScreen(),
      const DashbordScreen(),
      const UplodeProduct(),
    ];
    return Directionality(
      textDirection: TextDirection.rtl,
      child:
          Consumer<ConnectivityProvider>(builder: (context, connection, child) {
        return Stack(
          children: [
            Scaffold(
              bottomNavigationBar: BottomNavigationBar(
                backgroundColor: Colors.white,
                elevation: 0.0,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.blueGrey.shade700,
                // unselectedItemColor: Colors.red,
                currentIndex: _selectedIndex,
                selectedLabelStyle:
                    const TextStyle(fontWeight: FontWeight.w500),
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: 'خانه'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.search), label: 'دسته بندی'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.shop), label: 'فروشگاها'),
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
              body: _tabs!.elementAt(_selectedIndex),
            ),
            if (!connection.isInternetStable)
              NoInternetScreen(context: context).showModel()
          ],
        );
      }),
    );
  }
}
