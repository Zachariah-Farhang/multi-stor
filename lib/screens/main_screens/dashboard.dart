import 'package:flutter/material.dart';
import 'package:multi_store_app/components/dashboard_components/edit_profile.dart';
import 'package:multi_store_app/components/dashboard_components/manage_products.dart';
import 'package:multi_store_app/components/dashboard_components/my_sotre.dart';
import 'package:multi_store_app/components/dashboard_components/supplier_orders.dart';

const String abslutPath = "assets/images/supplierImages/";
final List<String> imagePaht = [
  "$abslutPath" "mystores.png",
  "$abslutPath" "editprofile.png",
  "$abslutPath" "orders.png",
  "$abslutPath" "manageproducts.png",
];
final List<String> labels = [
  "فروشگاهای من",
  "ویرایش پروفایل",
  "سفارشات",
  "مدریت سفارشات"
];

const List<Widget> pagesOnDashboard = [
  MyStore(),
  EditProfile(),
  SupplierOrders(),
  ManageProducts()
];

class DashbordScreen extends StatelessWidget {
  const DashbordScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "داشبورد",
          style: TextStyle(color: Colors.black87),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/welcome_screen');
              },
              icon: const RotatedBox(
                  quarterTurns: -2,
                  child: Icon(Icons.logout, color: Colors.black87)))
        ],
      ),
      body: GridView.count(
        physics: const BouncingScrollPhysics(),
        crossAxisSpacing: 25,
        mainAxisSpacing: 25,
        padding: const EdgeInsets.all(16),
        crossAxisCount: 2,
        children: List.generate(4, (index) {
          return Material(
            elevation: 8,
            shadowColor: Colors.grey.shade900,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
            color: Colors.grey.shade400,
            child: InkWell(
              splashColor: Colors.black38,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => pagesOnDashboard[index]));
              },
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 100,
                      child: Image(
                        image: AssetImage(imagePaht[index]),
                      ),
                    ),
                    Text(
                      labels[index],
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                    )
                  ]),
            ),
          );
        }),
      ),
    );
  }
}
