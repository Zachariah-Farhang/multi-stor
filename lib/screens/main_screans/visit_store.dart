import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multi_store_app/widgets/app_bar_back_button.dart';

import '../../models/product_model.dart';
import '../minor_screens/product_detiels.dart';

class VisitStore extends StatefulWidget {
  final String userId;
  const VisitStore({super.key, required this.userId});

  @override
  State<VisitStore> createState() => _VisitStoreState();
}

class _VisitStoreState extends State<VisitStore> {
  bool following = false;
  CollectionReference customer =
      FirebaseFirestore.instance.collection('suppliers');
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> productsStreem = FirebaseFirestore.instance
        .collection('products')
        .where('sid', isEqualTo: widget.userId)
        .snapshots();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Material(
        child: SafeArea(
          child: FutureBuilder(
              future: customer.doc(widget.userId).get(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                      child: Text(
                    "خطای ناشناخته رخ داده است",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontFamily: 'Kanun'),
                  ));
                }

                if (snapshot.hasData && !snapshot.data!.exists) {
                  return const Center(
                      child: Text(
                    "فروشگاهی با این آیدی وجود ندارد",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontFamily: 'Kanun'),
                  ));
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  Map<String, dynamic> data =
                      snapshot.data!.data() as Map<String, dynamic>;

                  return Scaffold(
                    floatingActionButton: FloatingActionButton(
                      backgroundColor: Colors.greenAccent.shade700,
                      child: const Icon(
                        FontAwesomeIcons.whatsapp,
                        size: 30,
                      ),
                      onPressed: () {},
                    ),
                    backgroundColor: Colors.blueGrey.shade100,
                    appBar: AppBar(
                      leading: const AppBarBackButton(
                        color: Colors.white,
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          DottedBorder(
                            color: Colors.blueAccent.shade400,
                            radius: const Radius.circular(16),
                            strokeWidth: 4,
                            borderType: BorderType.RRect,
                            child: Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image:
                                          NetworkImage(data['profileImage']))),
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                data['storeName'],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Kanun'),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    following = !following;
                                  });
                                },
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  decoration: BoxDecoration(
                                      color: Colors.lime.shade700,
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                        width: 2,
                                      )),
                                  child: data['sid'] ==
                                          FirebaseAuth.instance.currentUser!.uid
                                      ? Row(
                                          textDirection: TextDirection.rtl,
                                          children: [
                                            Text(
                                              'ویرایش',
                                              style: TextStyle(
                                                  color: Colors.pink.shade500,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Kanun'),
                                            ),
                                            const SizedBox(
                                              width: 6,
                                            ),
                                            Icon(
                                              Icons.edit,
                                              color: Colors.pink.shade900,
                                            )
                                          ],
                                        )
                                      : Row(
                                          textDirection: TextDirection.rtl,
                                          children: [
                                            Text(
                                              following
                                                  ? 'دنبال نکردن'
                                                  : 'دنبال کردن',
                                              style: TextStyle(
                                                  color: Colors.pink.shade500,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Kanun'),
                                            ),
                                            const SizedBox(
                                              width: 6,
                                            ),
                                            following
                                                ? Icon(
                                                    Icons.verified,
                                                    color: Colors.pink.shade900,
                                                  )
                                                : const Text(''),
                                          ],
                                        ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      toolbarHeight: MediaQuery.of(context).size.height * 0.2,
                      flexibleSpace: Image.asset(
                        'assets/images/inapp/coverimage.jpg',
                        fit: BoxFit.fill,
                      ),
                    ),
                    body: StreamBuilder<QuerySnapshot>(
                      stream: productsStreem,
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text(
                            ' یک خطای ناشناخته رخ داد در حال بررسی $snapshot.error ',
                            style: const TextStyle(fontSize: 18),
                          );
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (snapshot.data!.docs.isEmpty) {
                          return const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'اطلاعات یافت نشد در حال بررسی!',
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                CircularProgressIndicator()
                              ],
                            ),
                          );
                        }
                        return MasonryGridView.count(
                          physics: const BouncingScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          crossAxisCount: 2,
                          itemBuilder: (context, index) {
                            return ProductModel(
                              productSid: snapshot.data!.docs[index]['sid'],
                              imagePath: snapshot.data!.docs[index]
                                  ['product_images'][0],
                              productShortDetails: snapshot.data!.docs[index]
                                  ['product_name'],
                              productPrice: snapshot.data!.docs[index]
                                  ['product_price'],
                              isFavorite: false,
                              hasDescount: false,
                              descount: 0,
                              onTop: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      settings: const RouteSettings(),
                                      builder: (context) => ProductDetiels(
                                            proId: snapshot.data!.docs[index]
                                                ['proId'],
                                            mainCateg: snapshot
                                                .data!.docs[index]['maincatig'],
                                            subCateg: snapshot.data!.docs[index]
                                                ['subcatig'],
                                          )),
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                  );
                }

                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'در حال دریافت اطلاعات',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CircularProgressIndicator()
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
