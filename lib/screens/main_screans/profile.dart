import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_app/components/customer_components/customer_orders.dart';
import 'package:multi_store_app/components/customer_components/wishlist.dart';
import 'package:multi_store_app/screens/main_screans/cart.dart';
import 'package:multi_store_app/widgets/app_bar_back_button.dart';
import '../../widgets/alirt_dialog.dart';
import '../../widgets/divider.dart';
import '../../widgets/reuseable_continer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference customer =
      FirebaseFirestore.instance.collection('customers');
  String userId = '';
  String userName = '';
  String phoneNumber = '';
  String email = '';
  String address = '';
  String profileIamge = '';
  void logOut() async {
    await FirebaseAuth.instance.signOut().whenComplete(() {
      Navigator.pop(context);
      Navigator.pushReplacementNamed(context, '/welcome_screen');
    });
  }

  void popUp() {
    Navigator.pop(context);
  }

  void getData() {
    userId = FirebaseAuth.instance.currentUser!.uid;
    customer.doc(userId).get().then((DocumentSnapshot documentSnapshot) {
      
        if (mounted) {
          if (documentSnapshot.exists) {
            var data = documentSnapshot.data() as Map<String, dynamic>;
            setState(() {
              userName = data['name'];
              phoneNumber = data['phone'];
              email = data['email'];
              address = data['address'];
              profileIamge = data['profileImage'] ?? '';
            });
          } else {
            String defultName = 'User';
            int id = Random().nextInt(100000);

            String defultUserName = defultName + id.toString();

            setState(() {
              userName = defultUserName;
              email = '$defultUserName@gmail.com';
              address = defultUserName;
              phoneNumber = id.toString();
            });
          }
        }
      
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        body: Stack(children: [
          Container(
            height: 210,
            decoration: const BoxDecoration(
                gradient:
                    LinearGradient(colors: [Colors.yellow, Colors.brown])),
          ),
          CustomScrollView(physics: const BouncingScrollPhysics(), slivers: [
            SliverAppBar(
              pinned: true,
              elevation: 0,
              backgroundColor: Colors.white,
              expandedHeight: 160,
              flexibleSpace: LayoutBuilder(
                builder: (context, constraints) {
                  return FlexibleSpaceBar(
                    centerTitle: true,
                    title: AnimatedOpacity(
                      opacity: constraints.biggest.height <= 100 ? 1 : 0,
                      duration: const Duration(milliseconds: 200),
                      child: const Text(
                        'پروفایل',
                        style: TextStyle(color: Colors.black87, fontSize: 29),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    background: Container(
                      padding: const EdgeInsets.only(top: 20),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Colors.yellow,
                          Colors.brown,
                        ]),
                      ),
                      child: Column(children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: profileIamge.isNotEmpty
                              ? Image.network(profileIamge).image
                              : const AssetImage(
                                  "assets/images/tabImages/men.png"),
                        ),
                        Text(
                          userName,
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        )
                      ]),
                    ),
                  );
                },
              ),
            ),
            SliverToBoxAdapter(
              child: Column(children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 80,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ReusableCotiner(
                        decoration: const BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(50),
                                bottomRight: Radius.circular(50))),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CartScreen(
                                backButtom: AppBarBackButton(),
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          "سبدخرید",
                          style: TextStyle(color: Colors.yellow, fontSize: 24),
                        ),
                      ),
                      Expanded(
                        child: ReusableCotiner(
                          decoration: const BoxDecoration(
                            color: Colors.black54,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CustomerOrders(),
                              ),
                            );
                          },
                          child: const Text(
                            "سفارشات",
                            style:
                                TextStyle(color: Colors.yellow, fontSize: 24),
                          ),
                        ),
                      ),
                      ReusableCotiner(
                        decoration: const BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                bottomLeft: Radius.circular(50))),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const WishlistScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "موردعلاقه ها",
                          style: TextStyle(color: Colors.yellow, fontSize: 24),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.grey.shade300,
                  child: Column(children: [
                    const SizedBox(
                      height: 150,
                      child: Image(
                        image: AssetImage("assets/images/tabImages/bags.png"),
                      ),
                    ),
                    const ReuseableSizedBox(
                      text: "اطلاعات حساب",
                    ),
                    Container(
                      margin: const EdgeInsets.all(8),
                      height: 260,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16)),
                      child: Column(
                        children: [
                          Expanded(
                            child: ReusableListTile(
                              onTop: () {},
                              title: "ایمیل آدرس",
                              subTitle: email,
                              icon: Icons.email,
                            ),
                          ),
                          const ReuseableDivider(),
                          Expanded(
                            child: ReusableListTile(
                              onTop: () {},
                              title: "شماره تماس",
                              subTitle: phoneNumber,
                              icon: Icons.phone,
                            ),
                          ),
                          const ReuseableDivider(),
                          Expanded(
                            child: ReusableListTile(
                              onTop: () {},
                              title: "آدرس",
                              subTitle: address,
                              icon: Icons.location_on,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const ReuseableSizedBox(text: "تنظیمات حساب"),
                    Container(
                      margin: const EdgeInsets.all(8),
                      height: profileIamge.isNotEmpty ? 260 : 80,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16)),
                      child: Column(
                        children: [
                          profileIamge.isNotEmpty
                              ? Expanded(
                                  child: ReusableListTile(
                                    onTop: () {},
                                    title: "ویرایش پروفایل",
                                    icon: Icons.edit,
                                  ),
                                )
                              : const SizedBox(),
                          profileIamge.isNotEmpty
                              ? const ReuseableDivider()
                              : const SizedBox(),
                          profileIamge.isNotEmpty
                              ? Expanded(
                                  child: ReusableListTile(
                                    onTop: () {},
                                    title: "تغیر رمز عبور",
                                    icon: Icons.lock,
                                  ),
                                )
                              : const SizedBox(),
                          profileIamge.isNotEmpty
                              ? const ReuseableDivider()
                              : const SizedBox(),
                          Expanded(
                            child: ReusableListTile(
                              onTop: () {
                                CuperAlertDialog(
                                        context: context,
                                        agree: 'بلی',
                                        desAgree: 'نخیر',
                                        agreeFun: logOut,
                                        desAgreeFun: popUp,
                                        title: 'خارج شدن',
                                        descreption:
                                            'آیا مطمعین هستید که میخواهید خارج شوید؟')
                                    .showAlertDialog();
                              },
                              title: "خروج",
                              icon: Icons.logout,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ]),
            ),
          ]),
        ]),
      ),
    );
  }
}

class ReusableListTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData icon;
  final void Function()? onTop;
  const ReusableListTile({
    super.key,
    required this.title,
    this.subTitle = '',
    required this.icon,
    this.onTop,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        splashColor: Colors.black54,
        onTap: onTop,
        child: Center(
          child: ListTile(
            title: Text(title),
            subtitle: subTitle != "" ? Text(subTitle) : null,
            leading: Icon(icon),
          ),
        ),
      ),
    );
  }
}

class ReuseableSizedBox extends StatelessWidget {
  final String text;
  const ReuseableSizedBox({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 40,
            width: 50,
            child: Divider(
              color: Colors.grey,
              thickness: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              text,
              style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 40,
            width: 50,
            child: Divider(
              color: Colors.grey,
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
