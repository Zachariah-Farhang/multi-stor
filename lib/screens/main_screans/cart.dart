import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multi_store_app/providers/cart_provider.dart';
import 'package:provider/provider.dart';
import '../../widgets/reuseable_bottun.dart';

class CartScreen extends StatefulWidget {
  final Widget? backButtom;
  const CartScreen({super.key, this.backButtom});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void replacePage() {
    Navigator.canPop(context)
        ? Navigator.pop(context)
        : Navigator.pushReplacementNamed(context, '/customer_screen');
  }

  Cart cart = Cart();
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Material(
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.black12,
            appBar: AppBar(
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.white,
              title: const Text(
                "سبدخرید",
                style: TextStyle(color: Colors.black87),
              ),
              leading: widget.backButtom,
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.delete_forever,
                      color: Colors.black87,
                    ))
              ],
            ),
            body: Consumer<Cart>(
              builder: (context, cart, child) {
                return cart.count != 0
                    ? ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.only(bottom: 60),
                        itemCount: cart.count,
                        itemBuilder: ((context, index) {
                          final product = cart.getItem[index];
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              product.price.toString(),
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.red),
                                            ),
                                            Container(
                                              height: 35,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey.shade200,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              child: Row(
                                                children: [
                                                  product.qty == 1
                                                      ? IconButton(
                                                          onPressed: () {
                                                            context
                                                                .read<Cart>()
                                                                .removeItem(
                                                                    product);
                                                            // showCupertinoModalPopup<
                                                            //     void>(
                                                            //   context: context,
                                                            //   builder: (BuildContext
                                                            //           context) =>
                                                            //       CupertinoActionSheet(
                                                            //     title: const Text(
                                                            //         'RemoveItem'),
                                                            //     message: const Text(
                                                            //         'Are you sure to remove this item ?'),
                                                            //     actions: <CupertinoActionSheetAction>[
                                                            //       CupertinoActionSheetAction(
                                                            //           child: const Text(
                                                            //               'Move To Wishlist'),
                                                            //           onPressed:
                                                            //               () async {
                                                            //             // context
                                                            //             //             .read<Wish>()
                                                            //             //             .getWishItems
                                                            //             //             .firstWhereOrNull(
                                                            //             //                 (element) =>
                                                            //             //                     element.documentId ==
                                                            //             //                     product
                                                            //             //                         .documentId) !=
                                                            //             //         null
                                                            //             //     ? context
                                                            //             //         .read<Cart>()
                                                            //             //         .removeItem(product)
                                                            //             //     : await context
                                                            //             //         .read<Wish>()
                                                            //             //         .addWishItem(
                                                            //             //             product.name,
                                                            //             //             product.price,
                                                            //             //             1,
                                                            //             //             product.qntty,
                                                            //             //             product
                                                            //             //                 .imagesUrl,
                                                            //             //             product
                                                            //             //                 .documentId,
                                                            //             //             product.suppId);
                                                            //             () {
                                                            //               context
                                                            //                   .read<
                                                            //                       Cart>()
                                                            //                   .removeItem(
                                                            //                       cart.getItem[index]);
                                                            //               Navigator.pop(
                                                            //                   context);
                                                            //             };
                                                            //           }),
                                                            //       CupertinoActionSheetAction(
                                                            //         child: const Text(
                                                            //             'Delete Item'),
                                                            //         onPressed: () {
                                                            //           context
                                                            //               .read<
                                                            //                   Cart>()
                                                            //               .removeItem(
                                                            //                   cart.getItem[
                                                            //                       index]);
                                                            //           Navigator.pop(
                                                            //               context);
                                                            //         },
                                                            //       )
                                                            //     ],
                                                            //     cancelButton:
                                                            //         TextButton(
                                                            //             onPressed:
                                                            //                 () {
                                                            //               Navigator.pop(
                                                            //                   context);
                                                            //             },
                                                            //             child: const Text(
                                                            //                 'Cancel',
                                                            //                 style:
                                                            //                     TextStyle(
                                                            //                   fontSize:
                                                            //                       20,
                                                            //                   color: Colors
                                                            //                       .red,
                                                            //                 ))),
                                                            //   ),
                                                            // );
                                                          },
                                                          icon: const Icon(
                                                            Icons
                                                                .delete_forever,
                                                            size: 18,
                                                          ))
                                                      : IconButton(
                                                          onPressed: () {
                                                            cart.decrement(
                                                                product);
                                                          },
                                                          icon: const Icon(
                                                            FontAwesomeIcons
                                                                .minus,
                                                            size: 18,
                                                          )),
                                                  Text(
                                                    product.qty.toString(),
                                                    style: product.qty
                                                                .toString() ==
                                                            product.qntty
                                                        ? const TextStyle(
                                                            fontSize: 20,
                                                            color: Colors.red)
                                                        : const TextStyle(
                                                            fontSize: 20,
                                                          ),
                                                  ),
                                                  IconButton(
                                                      onPressed: product.qty
                                                                  .toString() ==
                                                              product.qntty
                                                          ? null
                                                          : () {
                                                              cart.increment(
                                                                  product);
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

                          // CartModel(
                          //     product: Product(
                          //         name: cart.getItem[index].name,
                          //         price: cart.getItem[index].price,
                          //         qty: 1,
                          //         qntty: cart.getItem[index].qntty,
                          //         imageUrl: cart.getItem[index].imageUrl,
                          //         productId: cart.getItem[index].productId,
                          //         suppId: cart.getItem[index].suppId),
                          //     cart: cart);
                        }),
                      )
                    : Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const AutoSizeText(
                                "سبدخرید شما خالی است !",
                                style: TextStyle(fontSize: 30),
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              ReuseableButton(
                                onPressed: replacePage,
                                color: Colors.blueAccent,
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "به خرید ادامه دهید",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                ),
                              )
                            ]),
                      );
              },
            ),
            bottomSheet: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Text(
                          "مجموعه :",
                          style: TextStyle(fontSize: 22),
                        ),
                        Text(
                          " \$۰۰,۰۰",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    ReuseableButton(
                        onPressed: () {},
                        color: Colors.yellow,
                        child: const Text("پرداخت",
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 22,
                                fontWeight: FontWeight.bold)))
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
