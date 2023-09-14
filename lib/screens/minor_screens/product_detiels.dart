import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

class ProductDetiels extends StatefulWidget {
  final String proId;
  const ProductDetiels({super.key, required this.proId});

  @override
  State<ProductDetiels> createState() => _ProductDetielsState();
}

class _ProductDetielsState extends State<ProductDetiels> {
  QuerySnapshot? productQuerySnapshot;
  List<dynamic> proImages = [];
  String proQuantity = '';
  String proDescount = '';
  String proDetiels = '';
  String proPrice = '';
  String proName = '';

  Future<void> getdata(String proId) async {
    productQuerySnapshot = await FirebaseFirestore.instance
        .collection('products')
        .where('proId', isEqualTo: proId)
        .get();

    var data = productQuerySnapshot!.docs[0].data() as Map<String, dynamic>;
    proImages = data['product_images'];
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
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<void>(
            future: getdata(widget.proId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Column(children: [
                  Stack(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.50,
                        child: Swiper(
                            pagination: const SwiperPagination(
                                builder: SwiperPagination.fraction),
                            itemBuilder: (context, index) {
                              return Image(
                                image: NetworkImage(proImages[index]),
                                fit: BoxFit.fill,
                              );
                            },
                            itemCount: proImages.length),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                                onTap: () => Navigator.of(context).pop(),
                                child: const Icon(Icons.arrow_back_ios)),
                            const Icon(Icons.share)
                          ],
                        ),
                      ),
                    ],
                  )
                ]); // Replace with your actual widget
              } else {
                // Display a loading indicator or placeholder while initializing
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
