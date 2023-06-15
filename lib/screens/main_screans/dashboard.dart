import 'package:flutter/material.dart';

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

class DashbordScreen extends StatelessWidget {
  const DashbordScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "داشبورد",
          style: TextStyle(color: Colors.black87),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: RotatedBox(
                  quarterTurns: -2,
                  child: Icon(Icons.logout, color: Colors.black87)))
        ],
      ),
      body: GridView.count(
        physics: BouncingScrollPhysics(),
        crossAxisSpacing: 25,
        mainAxisSpacing: 25,
        padding: EdgeInsets.all(16),
        crossAxisCount: 2,
        children: List.generate(4, (index) {
          return Material(
            elevation: 8,
            shadowColor: Colors.grey.shade900,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
            color: Colors.grey.shade400,
            child: InkWell(
              splashColor: Colors.black38,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
              onTap: () {},
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
                      style: TextStyle(
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
