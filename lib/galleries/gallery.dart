import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:multi_store_app/components/supplier_components/product.dart';
import 'package:multi_store_app/screens/minor_screens/product_detiels.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen(
      {super.key,
      required this.category,
      this.subCategory,
      required this.scafoldKey});

  final String category;
  final GlobalKey<ScaffoldMessengerState> scafoldKey;
  final String? subCategory;

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> productsStreem = FirebaseFirestore.instance
        .collection('products')
        .where('maincatig', isEqualTo: widget.category)
        .where('subcatig', isEqualTo: widget.subCategory)
        .snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: productsStreem,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text(
            ' !یک خطای ناشناخته رخ داد در حال بررسی $snapshot.error ',
            style: const TextStyle(fontSize: 18),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
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
              productQntty: snapshot.data!.docs[index]['product_qnnty'],
              imagesUrl: snapshot.data!.docs[index]['product_images'],
              productName: snapshot.data!.docs[index]['product_name'],
              productPrice: snapshot.data!.docs[index]['product_price'],
              hasDescount: false,
              descount: 0,
              scafoldKey: widget.scafoldKey,
              productId: snapshot.data!.docs[index]['proId'],
              onTop: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      settings: const RouteSettings(),
                      builder: (context) => ProductDetiels(
                            proId: snapshot.data!.docs[index]['proId'],
                            mainCateg: snapshot.data!.docs[index]['maincatig'],
                            subCateg: snapshot.data!.docs[index]['subcatig'],
                          )),
                );
              },
            );
          },
        );
      },
    );
  }
}
