import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../providers/cart_provider.dart';
import '../../models/product_model.dart';

class CartModel extends StatelessWidget {
  const CartModel({Key? key, required this.product, required this.cart})
      : super(key: key);

  final Product product;
  final Cart cart;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Card(
          child: Row(
        children: [
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Image.network(
                product.imageUrl.first,
                fit: BoxFit.fill,
                height: 100,
              ),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade700),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.price.toString(),
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Grunge',
                            color: Colors.red),
                      ),
                      Container(
                        height: 35,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          children: [
                            product.qty != 1
                                ? IconButton(
                                    onPressed: () {
                                      // showCupertinoModalPopup<void>(
                                      //   context: context,
                                      //   builder: (BuildContext context) =>
                                      //       CupertinoActionSheet(
                                      //     title: const Text('RemoveItem'),
                                      //     message: const Text(
                                      //         'Are you sure to remove this item ?'),
                                      //     actions: <
                                      //         CupertinoActionSheetAction>[
                                      //       CupertinoActionSheetAction(
                                      //           child: const Text(
                                      //               'Move To Wishlist'),
                                      //           onPressed: () async {
                                      //             context
                                      //                         .read<Wish>()
                                      //                         .getWishItems
                                      //                         .firstWhereOrNull(
                                      //                             (element) =>
                                      //                                 element.documentId ==
                                      //                                 product
                                      //                                     .documentId) !=
                                      //                     null
                                      //                 ? context
                                      //                     .read<Cart>()
                                      //                     .removeItem(product)
                                      //                 : await context
                                      //                     .read<Wish>()
                                      //                     .addWishItem(
                                      //                         product.name,
                                      //                         product.price,
                                      //                         1,
                                      //                         product.qntty,
                                      //                         product
                                      //                             .imagesUrl,
                                      //                         product
                                      //                             .documentId,
                                      //                         product.suppId);
                                      //             () {
                                      //               context
                                      //                   .read<Cart>()
                                      //                   .removeItem(product);
                                      //               Navigator.pop(context);
                                      //             };
                                      //           }),
                                      //       CupertinoActionSheetAction(
                                      //         child:
                                      //             const Text('Delete Item'),
                                      //         onPressed: () {
                                      //           context
                                      //               .read<Cart>()
                                      //               .removeItem(product);
                                      //           Navigator.pop(context);
                                      //         },
                                      //       )
                                      //     ],
                                      //     cancelButton: TextButton(
                                      //         onPressed: () {
                                      //           Navigator.pop(context);
                                      //         },
                                      //         child: const Text('Cancel',
                                      //             style: TextStyle(
                                      //               fontSize: 20,
                                      //               color: Colors.red,
                                      //             ))),
                                      //   ),
                                      // );
                                    },
                                    icon: const Icon(
                                      Icons.delete_forever,
                                      size: 18,
                                    ))
                                : IconButton(
                                    onPressed: () {
                                      cart.decrement(product);
                                      debugPrint(product.qty.toString());
                                    },
                                    icon: const Icon(
                                      FontAwesomeIcons.minus,
                                      size: 18,
                                    )),
                            Text(
                              product.qty.toString(),
                              style: product.qty.toString() == product.qntty
                                  ? const TextStyle(
                                      fontSize: 20, color: Colors.red)
                                  : const TextStyle(
                                      fontSize: 20,
                                    ),
                            ),
                            IconButton(
                                onPressed: () {
                                  cart.increment(product);
                                  debugPrint(product.qty.toString());
                                },
                                icon: const Icon(
                                  FontAwesomeIcons.plus,
                                  size: 18,
                                ))
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
