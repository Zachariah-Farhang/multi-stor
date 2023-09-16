import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:multi_store_app/widgets/reuseable_bottun.dart';

import 'package:multi_store_app/widgets/reuseable_divider.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../../models/product_model.dart';

class ProductDetiels extends StatefulWidget {
  final String proId;
  final String mainCateg;
  final String subCateg;
  const ProductDetiels({
    super.key,
    required this.proId,
    required this.mainCateg,
    required this.subCateg,
  });

  @override
  State<ProductDetiels> createState() => _ProductDetielsState();
}

class _ProductDetielsState extends State<ProductDetiels> {
  QuerySnapshot? productQuerySnapshot;
  List<dynamic> proImages = [];
  String proQuantity = '';
  String proMainCateg = '';
  String proSubCateg = '';
  String proDescount = '';
  String proDetiels = '';
  String proPrice = '';
  String proName = '';

  Future<void> getdata(String proId) async {
    try {
      productQuerySnapshot = await FirebaseFirestore.instance
          .collection('products')
          .where('proId', isEqualTo: proId)
          .get();

      var data = productQuerySnapshot!.docs[0].data() as Map<String, dynamic>;
      proImages = data['product_images'];
      proDescount = data['product_descount'];
      proDetiels = data['product_detiels'];
      proName = data['product_name'];
      proPrice = data['product_price'];
      proQuantity = data['product_covantity'];
      proMainCateg = data['maincatig'];
      proSubCateg = data['subcatig'];
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> productsStreem = FirebaseFirestore.instance
        .collection('products')
        .where('maincatig', isEqualTo: widget.subCateg)
        .where(
          'subcatig',
          isEqualTo: widget.mainCateg,
        )
        .snapshots();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SafeArea(
            child: FutureBuilder<void>(
                future: getdata(widget.proId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.50,
                                child: Swiper(
                                    pagination: const SwiperPagination(
                                        builder: SwiperPagination.fraction),
                                    itemBuilder: (context, index) {
                                      return const Image(
                                        image: AssetImage(
                                            'assets/images/welcome/man.png'),
                                        fit: BoxFit.fill,
                                      );
                                    },
                                    itemCount: proImages.length),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                      onTap: () => Navigator.of(context).pop(),
                                      child: const Icon(Icons.arrow_back_ios)),
                                  const Icon(Icons.share)
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Text(
                              proName,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      proPrice,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.red.shade500),
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      'افغانی',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red.shade500),
                                    ),
                                  ],
                                ),
                                const Icon(Icons.access_time)
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Text(proQuantity),
                              const SizedBox(
                                width: 4,
                              ),
                              const Text('عدد در انبار موجود است'),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 16, top: 10),
                            child: ReuseableSizedBox(text: 'اطلاعات محصول'),
                          ),
                          Text(
                            proDetiels,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 16),
                            child: ReuseableSizedBox(text: 'محصولات پیشنهادی'),
                          ),
                          SizedBox(
                            child: StreamBuilder<QuerySnapshot>(
                              stream: productsStreem,
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasError) {
                                  return Text(
                                    ' !یک خطای ناشناخته رخ داد در حال بررسی $snapshot.error ',
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                return SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(),
                                  child: StaggeredGridView.countBuilder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: snapshot.data!.docs.length,
                                      crossAxisCount: 2,
                                      itemBuilder: (context, index) {
                                        return ProductModel(
                                          imagePath: snapshot.data!.docs[index]
                                              ['product_images'][0],
                                          productShortDetails: snapshot.data!
                                              .docs[index]['product_name'],
                                          productPrice: snapshot.data!
                                              .docs[index]['product_price'],
                                          isFavorite: false,
                                          hasDescount: false,
                                          descount: 0,
                                          onTop: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  settings:
                                                      const RouteSettings(),
                                                  builder: (context) =>
                                                      ProductDetiels(
                                                        proId: snapshot.data!
                                                                .docs[index]
                                                            ['proId'],
                                                        mainCateg: snapshot
                                                                .data!
                                                                .docs[index]
                                                            ['maincatig'],
                                                        subCateg: snapshot.data!
                                                                .docs[index]
                                                            ['subcatig'],
                                                      )),
                                            );
                                          },
                                        );
                                      },
                                      staggeredTileBuilder: (context) =>
                                          const StaggeredTile.fit(1)),
                                );
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
                            ),
                          )
                        ],
                      ),
                    ); // Replace with your actual widget
                  } else {
                    // Display a loading indicator or placeholder while initializing
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
          ),
        ),
        bottomSheet: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.store)),
                const SizedBox(
                  width: 10,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.shopping_cart),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: ReuseableButton(
                  onPressed: () {},
                  color: Colors.amber,
                  child: const Padding(
                    padding:
                        EdgeInsets.only(left: 32, right: 32, top: 4, bottom: 4),
                    child: Text('افزودن به سبد خرید'),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
