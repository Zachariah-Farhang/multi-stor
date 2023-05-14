import 'package:flutter/material.dart';

// TODO: I have created a fulstatwidget for customer page that have a navigationbar.
class CustomerHomeScrean extends StatefulWidget {
  const CustomerHomeScrean({super.key});

  @override
  State<CustomerHomeScrean> createState() => _CustomerHomeScreanState();
}

class _CustomerHomeScreanState extends State<CustomerHomeScrean> {
  int _selectedIndex = 0;
  final List<Widget> _tabs = const [
    Center(child: Text('Home')),
    Center(child: Text('Category')),
    Center(child: Text('Stores')),
    Center(child: Text('Cart')),
    Center(child: Text('Profile')),
  ];
  @override
  Widget build(BuildContext context) {
    // TODO: Scaffold is the root widget of the customer page.
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0.0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        // unselectedItemColor: Colors.red,
        currentIndex: _selectedIndex,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Category'),
          BottomNavigationBarItem(icon: Icon(Icons.shop), label: 'Stores'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
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
    );
  }
}
