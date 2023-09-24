import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProductModel extends StatelessWidget {
  final String imagePath;
  final String productShortDetails;
  final String productPrice;
  final String productSid;
  final bool isFavorite;
  final bool hasDescount;
  final int descount;
  final Function() onTop;
  const ProductModel(
      {super.key,
      required this.imagePath,
      required this.productShortDetails,
      required this.productPrice,
      required this.isFavorite,
      required this.hasDescount,
      required this.descount,
      required this.onTop,
      required this.productSid});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTop,
      child: Container(
        margin: const EdgeInsets.all(6),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(16)),
        child: Stack(children: [
          Column(
            children: [
              Container(
                  constraints: const BoxConstraints(
                    minHeight: 100,
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16)),
                    child: Image(
                      image: NetworkImage(imagePath),
                      // image: NetworkImage(imagePath),
                    ),
                  )),
              const SizedBox(
                height: 4,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  productShortDetails,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$ $productPrice ",
                    ),
                    productSid == FirebaseAuth.instance.currentUser!.uid
                        ? Icon(Icons.edit)
                        : Icon(isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border_outlined)
                  ],
                ),
              )
            ],
          ),
          hasDescount
              ? Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              bottomLeft: Radius.circular(30))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text('٪ ذخیره $descount '),
                      )),
                )
              : const SizedBox(),
        ]),
      ),
    );
  }
}
