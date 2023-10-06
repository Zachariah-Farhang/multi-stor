import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:multi_store_app/providers/cart_provider.dart';
import 'package:multi_store_app/providers/wish_provider.dart';
import 'package:multi_store_app/screens/main_screans/cart.dart';
import 'package:multi_store_app/screens/main_screans/visit_store.dart';
import 'package:multi_store_app/widgets/app_bar_back_button.dart';
import 'package:multi_store_app/widgets/badge_widget.dart';
import 'package:multi_store_app/widgets/reuseable_bottun.dart';
import 'package:multi_store_app/widgets/reuseable_divider.dart';
import 'package:multi_store_app/widgets/snackbarr.dart';
import 'package:provider/provider.dart';
import '../../components/supplier_components/product.dart';
import 'image_view_screen.dart';
import 'package:collection/collection.dart';
import 'package:badges/badges.dart' as badges;

class ProductDetiels extends StatefulWidget {
  const ProductDetiels({
    super.key,
    required this.proId,
    required this.mainCateg,
    required this.subCateg,
  });

  final String mainCateg;
  final String proId;
  final String subCateg;

  @override
  State<ProductDetiels> createState() => _ProductDetielsState();
}

class _ProductDetielsState extends State<ProductDetiels> {
  bool isLodingData = true;
  String proDescount = '';
  String proDetiels = '';
  String proId = '';
  List<dynamic> proImages = [];
  String proMainCateg = '';
  String proName = '';
  double proPrice = 0.0;
  String proQuantity = '';
  String proSubCateg = '';
  QuerySnapshot? productQuerySnapshot;
  Stream<QuerySnapshot>? productsStreem;
  String suppId = '';

  final GlobalKey<ScaffoldMessengerState> _scafoldKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    proId = widget.proId;
    super.initState();
  }

  Future<void> getdata(String productId) async {
    try {
      productQuerySnapshot = await FirebaseFirestore.instance
          .collection('products')
          .where('proId', isEqualTo: widget.proId)
          .get();
      productsStreem = FirebaseFirestore.instance
          .collection('products')
          .where('maincatig', isEqualTo: widget.mainCateg)
          .where(
            'subcatig',
            isEqualTo: widget.subCateg,
          )
          .where('proId', isNotEqualTo: widget.proId)
          .snapshots();

      var data = productQuerySnapshot!.docs[0].data() as Map<String, dynamic>;
      proImages = data['product_images'];
      proDescount = data['product_descount'];
      proDetiels = data['product_detiels'];
      proName = data['product_name'];
      proPrice = data['product_price'];
      proQuantity = data['product_qnnty'];
      proMainCateg = data['maincatig'];
      proSubCateg = data['subcatig'];
      proId = data['proId'];
      suppId = data['sid'];
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScaffoldMessenger(
        key: _scafoldKey,
        child: Scaffold(
          backgroundColor: Colors.grey.shade200,
          appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: InkWell(
                onTap: () => Navigator.pop(context),
                child: const Icon(
                  CupertinoIcons.back,
                  size: 32,
                  color: Colors.black,
                ),
              ),
              actions: [
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Icon(
                      CupertinoIcons.share,
                      size: 32,
                      color: Colors.black,
                    ),
                  ),
                ),
              ]),
          body: SingleChildScrollView(
            // padding: EdgeInsets.only(
            //     bottom: MediaQuery.of(context).size.height * 0.06),
            physics: const BouncingScrollPhysics(),
            child: SafeArea(
              child: FutureBuilder<void>(
                future: getdata(widget.proId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      proName != '') {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => ImageViewScreen(
                                        imageList: proImages,
                                      )))),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.60,
                            child: Swiper(
                                pagination: SwiperPagination(
                                    margin: EdgeInsets.zero,
                                    builder: SwiperCustomPagination(
                                        builder: (context, config) {
                                      return ConstrainedBox(
                                        constraints:
                                            const BoxConstraints.expand(
                                                height: 50.0),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child:
                                              const DotSwiperPaginationBuilder(
                                                      color: Colors.amber,
                                                      activeColor:
                                                          Colors.blueAccent,
                                                      size: 10.0,
                                                      activeSize: 20.0)
                                                  .build(context, config),
                                        ),
                                      );
                                    })),
                                itemBuilder: (context, index) {
                                  return CachedNetworkImage(
                                    imageUrl: proImages[index],
                                    progressIndicatorBuilder:
                                        (context, url, downloadProgress) =>
                                            Center(
                                      child: CircularProgressIndicator(
                                          value: downloadProgress.progress),
                                    ),
                                    fit: BoxFit.fill,
                                  );
                                },
                                itemCount: proImages.length),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: Text(
                                  proName,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          proPrice.toString(),
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Grunge',
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
                                    suppId ==
                                            FirebaseAuth
                                                .instance.currentUser!.uid
                                        ? const Icon(Icons.edit)
                                        : IconButton(
                                            onPressed: () {
                                              if (context
                                                      .read<Wish>()
                                                      .getWishItem
                                                      .firstWhereOrNull(
                                                          (product) =>
                                                              product
                                                                  .productId ==
                                                              widget.proId) !=
                                                  null) {
                                                context
                                                    .read<Wish>()
                                                    .removeItem(proId);
                                                Snackbar(
                                                  key: _scafoldKey,
                                                  content:
                                                      'محصول از مورد علاقه ها حذف شد',
                                                ).showsnackBar();
                                              } else {
                                                context
                                                    .read<Wish>()
                                                    .addToWishItem(
                                                      proName,
                                                      proPrice,
                                                      1,
                                                      proQuantity,
                                                      proImages,
                                                      proId,
                                                      suppId,
                                                    );
                                                Snackbar(
                                                  key: _scafoldKey,
                                                  content:
                                                      'محصول به مورد علاقه ها اضافه شد',
                                                ).showsnackBar();
                                              }
                                            },
                                            icon: context
                                                        .watch<Wish>()
                                                        .getWishItem
                                                        .firstWhereOrNull(
                                                            (product) =>
                                                                product
                                                                    .productId ==
                                                                widget.proId) ==
                                                    null
                                                ? const Icon(
                                                    Icons.favorite_border)
                                                : const Icon(Icons.favorite))
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
                                child:
                                    ReuseableSizedBox(text: 'محصولات پیشنهادی'),
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
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text('در حال در یافت اطلاعات !'),
                                            CircularProgressIndicator(),
                                          ],
                                        ),
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
                                      child: MasonryGridView.count(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 4,
                                        crossAxisSpacing: 4,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: snapshot.data!.docs.length,
                                        itemBuilder: ((context, index) {
                                          return ProductModel(
                                            productSid: snapshot
                                                .data!.docs[index]['sid'],
                                            productQntty: snapshot.data!
                                                .docs[index]['product_qnnty'],
                                            imagesUrl: snapshot.data!
                                                .docs[index]['product_images'],
                                            productName: snapshot.data!
                                                .docs[index]['product_name'],
                                            productPrice: snapshot.data!
                                                .docs[index]['product_price'],
                                            hasDescount: false,
                                            scafoldKey: _scafoldKey,
                                            productId: snapshot
                                                .data!.docs[index]['proId'],
                                            descount: 0,
                                            onTop: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  settings:
                                                      const RouteSettings(),
                                                  builder: (context) =>
                                                      ProductDetiels(
                                                    proId: snapshot.data!
                                                        .docs[index]['proId'],
                                                    mainCateg: snapshot
                                                            .data!.docs[index]
                                                        ['maincatig'],
                                                    subCateg: snapshot
                                                            .data!.docs[index]
                                                        ['subcatig'],
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        }),
                                      ),
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    );
                  } else {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AutoSizeText(
                              'در حال در یافت اطلاعات !',
                              minFontSize: 16,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            CircularProgressIndicator(),
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
          bottomNavigationBar: Container(
            color: Colors.white,
            child: FutureBuilder<void>(
              future: getdata(widget.proId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox();
                }

                if (snapshot.connectionState == ConnectionState.done &&
                    proName != '') {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      VisitStore(userId: suppId),
                                ),
                              );
                            },
                            icon: const Icon(Icons.store),
                          ),
                          const SizedBox(width: 10),
                          BadgeWidget(
                            content: context
                                .watch<Cart>()
                                .getCartItem
                                .length
                                .toString(),
                            child: IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const CartScreen(
                                      backButtom:
                                          AppBarBackButton(color: Colors.black),
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.shopping_cart),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: ReuseableButton(
                          onPressed: () {
                            context.read<Cart>().getCartItem.firstWhereOrNull(
                                          (product) =>
                                              product.productId == widget.proId,
                                        ) !=
                                    null
                                ? Snackbar(
                                    key: _scafoldKey,
                                    content:
                                        'این آیتم در حال حاضر در کارت موجود هست',
                                  ).showsnackBar()
                                : context.read<Cart>().addToCartItem(
                                      proName,
                                      proPrice,
                                      1,
                                      proQuantity,
                                      proImages,
                                      proId,
                                      suppId,
                                    );
                          },
                          color: Colors.amber,
                          child: const Padding(
                            padding: EdgeInsets.only(
                                left: 32, right: 32, top: 4, bottom: 4),
                            child: Text(
                              'افزودن به سبد خرید',
                              style: TextStyle(
                                fontFamily: 'Kanun',
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }

                return const SizedBox();
              },
            ),
          ),
        ),
      ),
    );
  }
}
