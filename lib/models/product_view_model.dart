import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

import '../providers/wish_provider.dart';
import '../screens/main_screans/visit_store.dart';
import '../utilities/global_values.dart';
import '../widgets/snackbarr_widget.dart';

class ProductModel extends StatelessWidget {
  const ProductModel(
      {super.key,
      required this.imagesUrl,
      required this.productName,
      required this.productPrice,
      required this.hasDescount,
      required this.descount,
      required this.onTop,
      required this.productSid,
      required this.productQntty,
      required this.scafoldKey,
      required this.productId,
      this.usePlace = ''});

  final int descount;
  final bool hasDescount;
  final List imagesUrl;
  final Function() onTop;
  final String productId;
  final String productName;
  final double productPrice;
  final String productQntty;
  final String productSid;
  final GlobalKey<ScaffoldMessengerState> scafoldKey;
  final String? usePlace;

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
                    child: CachedNetworkImage(
                      imageUrl: imagesUrl[0],
                      progressIndicatorBuilder: (context, url, progress) =>
                          CupertinoActivityIndicator(
                              radius: 20, color: Colors.amber.shade300),
                      // image: NetworkImage(imagePath),
                    ),
                  )),
              const SizedBox(
                height: 4,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  productName,
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
                      " $productPrice \$",
                      style: const TextStyle(fontFamily: 'Grunge'),
                    ),
                    productSid == FirebaseAuth.instance.currentUser!.uid
                        ? const Icon(Icons.edit)
                        : GlobalValues().userType == 'supplier'
                            ? usePlace == 'visitStore'
                                ? const SizedBox()
                                : IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => VisitStore(
                                            userId: productSid,
                                          ),
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.store),
                                  )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Material(
                                  borderRadius: BorderRadius.circular(30),
                                  child: IconButton(
                                      onPressed: () {
                                        if (context
                                                .read<Wish>()
                                                .getWishItem
                                                .firstWhereOrNull((product) =>
                                                    product.productId ==
                                                    productId) !=
                                            null) {
                                          context
                                              .read<Wish>()
                                              .removeItem(productId);
                                          Snackbar(
                                            key: scafoldKey,
                                            content:
                                                'محصول از علاقه مندی ها حذف شد',
                                          ).showsnackBar();
                                        } else {
                                          context.read<Wish>().addToWishItem(
                                              productName,
                                              productPrice,
                                              1,
                                              productQntty,
                                              imagesUrl,
                                              productId,
                                              productSid);
                                          Snackbar(
                                            key: scafoldKey,
                                            content:
                                                'محصول به علاقه مندی ها اضافه شد',
                                          ).showsnackBar();
                                        }
                                      },
                                      icon: context
                                                  .watch<Wish>()
                                                  .getWishItem
                                                  .firstWhereOrNull((product) =>
                                                      product.productId ==
                                                      productId) ==
                                              null
                                          ? const Icon(Icons.favorite_border)
                                          : const Icon(Icons.favorite)),
                                ),
                              )
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
