import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_app/models/product_model.dart';
import 'package:multi_store_app/screens/minor_screens/product_detiels.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class GalleryScreen extends StatefulWidget {
  final String category;
  final String? subCategory;
  const GalleryScreen({super.key, required this.category, this.subCategory});

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
        return StaggeredGridView.countBuilder(
            physics: const BouncingScrollPhysics(),
            itemCount: snapshot.data!.docs.length,
            crossAxisCount: 2,
            itemBuilder: (context, index) {
              return ProductModel(
                imagePath: snapshot.data!.docs[index]['product_images'][0],
                productShortDetails: snapshot.data!.docs[index]['product_name'],
                productPrice: snapshot.data!.docs[index]['product_price'],
                isFavorite: false,
                hasDescount: false,
                descount: 0,
                onTop: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        settings: const RouteSettings(),
                        builder: (context) => ProductDetiels(
                              proId: snapshot.data!.docs[index]['proId'],
                              mainCateg: snapshot.data!.docs[index]
                                  ['maincatig'],
                              subCateg: snapshot.data!.docs[index]['subcatig'],
                            )),
                  );
                },
              );
            },
            staggeredTileBuilder: (context) => const StaggeredTile.fit(1));
        // return ListView(
        //   children: snapshot.data!.docs
        //       .map((DocumentSnapshot document) {
        //         Map<String, dynamic> data =
        //             document.data()! as Map<String, dynamic>;
        //         return ListTile(
        //           leading:
        //               Image(image: NetworkImage(data['product_images'][0])),
        //           title: Text(data['product_name']),
        //           subtitle: Text(data['product_price']),
        //         );
        //       })
        //       .toList()
        //       .cast(),
        // );
      },
    );
  }
}
