import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_app/components/customer_components/customer_orders.dart';
import 'package:multi_store_app/components/customer_components/wishlist.dart';
import 'package:multi_store_app/providers/cart_provider.dart';
import 'package:multi_store_app/providers/wish_provider.dart';
import 'package:multi_store_app/components/customer_components/cart.dart';
import 'package:multi_store_app/utilities/global_values.dart';
import 'package:multi_store_app/widgets/app_bar_back_button_widget.dart';
import 'package:provider/provider.dart';
import '../../widgets/alirt_dialog_widget.dart';
import '../../widgets/divider_widget.dart';
import '../../widgets/reuseable_continer.dart';
import '../../widgets/reuseable_divider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  CollectionReference? collection;
  String userId = '';
  String userName = '';
  String phoneNumber = '';
  String email = '';
  String address = '';
  String profileIamge = '';

  void logOut() async {
    context.read<Cart>().clearCart();
    context.read<Wish>().clearWisList();
    await FirebaseAuth.instance.signOut().whenComplete(() {
      Navigator.pop(context);
      Navigator.pushReplacementNamed(context, '/welcome_screen');
    });
  }

  void popUp() {
    Navigator.pop(context);
  }

  void getData() {
    try {
      userId = FirebaseAuth.instance.currentUser!.uid;
      collection!.doc(userId).get().then((DocumentSnapshot documentSnapshot) {
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
          }
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void initState() {
    collection = FirebaseFirestore.instance.collection('anonymous');
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final highet = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        body: FutureBuilder(
            future: collection!.doc(userId).get(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      SliverAppBar(
                        pinned: true,
                        elevation: 0,
                        backgroundColor: Colors.white,
                        expandedHeight:
                            highet >= 720 ? highet * 0.20 : highet * 0.25,
                        flexibleSpace: LayoutBuilder(
                          builder: (context, constraints) {
                            return FlexibleSpaceBar(
                              centerTitle: true,
                              title: AnimatedOpacity(
                                opacity:
                                    constraints.biggest.height <= 100 ? 1 : 0,
                                duration: const Duration(milliseconds: 200),
                                child: const Text(
                                  'پروفایل',
                                  style: TextStyle(
                                      color: Colors.black87, fontSize: 29),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              background: Container(
                                padding: const EdgeInsets.only(top: 20),
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage(
                                          'assets/images/inapp/coverimage.jpg')),
                                  gradient: LinearGradient(colors: [
                                    Colors.yellow,
                                    Colors.brown,
                                  ]),
                                ),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 40,
                                        backgroundImage: GlobalValues()
                                                    .userType ==
                                                'customer'
                                            ? Image.network(snapshot
                                                    .data!['profileImage'])
                                                .image
                                            : const AssetImage(
                                                "assets/images/tabImages/men.png"),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        snapshot.data!['name'],
                                        style: TextStyle(
                                            color: Colors.amberAccent.shade700,
                                            fontSize: 24,
                                            fontFamily: 'Kanun',
                                            fontWeight: FontWeight.bold),
                                      )
                                    ]),
                              ),
                            );
                          },
                        ),
                      ),
                    ];
                  },
                  body: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
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
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(30),
                                  bottomRight: Radius.circular(30),
                                ),
                              ),
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
                                      backButtom: AppBarBackButton(
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: const AutoSizeText(
                                "سبدخرید",
                                minFontSize: 16,
                                style: TextStyle(
                                  color: Colors.yellow,
                                ),
                              ),
                            ),
                            Expanded(
                              child: ReusableCotiner(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero,
                                ),
                                decoration: const BoxDecoration(
                                  color: Colors.black54,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const CustomerOrders(),
                                    ),
                                  );
                                },
                                child: const AutoSizeText(
                                  "سفارشات",
                                  minFontSize: 16,
                                  style: TextStyle(
                                    color: Colors.yellow,
                                  ),
                                ),
                              ),
                            ),
                            ReusableCotiner(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  bottomLeft: Radius.circular(30),
                                ),
                              ),
                              decoration: const BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(50),
                                      bottomLeft: Radius.circular(50))),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const WishlistScreen(),
                                  ),
                                );
                              },
                              child: const AutoSizeText(
                                "علاقه مندی ها",
                                minFontSize: 16,
                                style: TextStyle(
                                  color: Colors.yellow,
                                ),
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
                              image: AssetImage(
                                  "assets/images/tabImages/bags.png"),
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
                                    subTitle: snapshot.data!['email'],
                                    icon: Icons.email,
                                  ),
                                ),
                                const ReuseableDivider(),
                                Expanded(
                                  child: ReusableListTile(
                                    onTop: () {},
                                    title: "شماره تماس",
                                    subTitle: snapshot.data!['phone'],
                                    icon: Icons.phone,
                                  ),
                                ),
                                const ReuseableDivider(),
                                Expanded(
                                  child: ReusableListTile(
                                    onTop: () {},
                                    title: "آدرس",
                                    subTitle: snapshot.data!['address'],
                                    icon: Icons.location_on,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const ReuseableSizedBox(text: "تنظیمات حساب"),
                          Container(
                            margin: const EdgeInsets.all(8),
                            height: GlobalValues().userType == 'customer'
                                ? 260
                                : 80,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16)),
                            child: Column(
                              children: [
                                GlobalValues().userType == 'customer'
                                    ? Expanded(
                                        child: ReusableListTile(
                                          onTop: () {},
                                          title: "ویرایش پروفایل",
                                          icon: Icons.edit,
                                        ),
                                      )
                                    : const SizedBox(),
                                GlobalValues().userType == 'customer'
                                    ? const ReuseableDivider()
                                    : const SizedBox(),
                                GlobalValues().userType == 'customer'
                                    ? Expanded(
                                        child: ReusableListTile(
                                          onTop: () {},
                                          title: "تغیر رمز عبور",
                                          icon: Icons.lock,
                                        ),
                                      )
                                    : const SizedBox(),
                                GlobalValues().userType == 'customer'
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
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CupertinoActivityIndicator(
                    radius: 40,
                    animating: true,
                    color: Colors.amber.shade900,
                  ),
                );
              }
              return Center(
                child: CupertinoActivityIndicator(
                  radius: 40,
                  animating: true,
                  color: Colors.amber.shade900,
                ),
              );
            }),
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
