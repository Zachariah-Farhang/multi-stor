import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_app/providers/cart_provider.dart';
import 'package:multi_store_app/providers/wish_provider.dart';

import 'package:multi_store_app/widgets/app_bar_back_button_widget.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({
    super.key,
  });

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final GlobalKey<ScaffoldMessengerState> _globalKey =
      GlobalKey<ScaffoldMessengerState>();

  void replacePage() {
    Navigator.canPop(context)
        ? Navigator.pop(context)
        : Navigator.pushReplacementNamed(
            context,
            '/customer_screen',
          );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Material(
        child: SafeArea(
          child: ScaffoldMessenger(
            key: _globalKey,
            child: Scaffold(
              backgroundColor: Colors.black12,
              appBar: AppBar(
                centerTitle: true,
                elevation: 0,
                backgroundColor: Colors.white,
                title: const Text(
                  'علاقه مندی ها',
                  style: TextStyle(color: Colors.black87),
                ),
                leading: const AppBarBackButton(color: Colors.black),
                // actions: [
                //   IconButton(
                //       onPressed: () {
                //         context.read<Cart>().count == 0
                //             ? Snackbar(
                //                     key: _globalKey,
                //                     content: 'سبد خرید شما خالی هست !')
                //                 .showsnackBar()
                //             : CuperAlertDialog(
                //                     context: context,
                //                     agree: 'بلی',
                //                     desAgree: 'نخیر',
                //                     agreeFun: () {
                //                       context.read<Cart>().clearCart();
                //                       Navigator.pop(context);
                //                     },
                //                     desAgreeFun: (() => Navigator.pop(context)),
                //                     title: 'پاک کردن سبد',
                //                     descreption:
                //                         'آیا مطمعین هستید که مخواهید تمام آیتم های سبد خرید را حذف کنید؟')
                //                 .showAlertDialog();
                //       },
                //       icon: const Icon(
                //         Icons.delete_forever,
                //         color: Colors.black87,
                //       ))
                // ],
              ),
              body: Consumer<Wish>(
                builder: (context, wish, child) {
                  return wish.count != 0
                      ? ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.only(bottom: 60),
                          itemCount: wish.count,
                          itemBuilder: ((context, index) {
                            final product = wish.getWishItem[index];
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
                                        height: 100,
                                        width: 100,
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
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                ' ${product.price}  \$',
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: 'Grunge',
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red),
                                              ),
                                              Container(
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                      color:
                                                          Colors.grey.shade200,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                  child: IconButton(
                                                      onPressed: () {
                                                        showCupertinoModalPopup<
                                                            void>(
                                                          context: context,
                                                          builder: (BuildContext
                                                                  context) =>
                                                              CupertinoActionSheet(
                                                            title: const Text(
                                                                'حدف آیتم'),
                                                            message: const Text(
                                                                'آیا مطمعین هستید که میخواهید این آیتم رو حذف کنید؟'),
                                                            actions: <CupertinoActionSheetAction>[
                                                              CupertinoActionSheetAction(
                                                                  child: const Text(
                                                                      'انتقال به سبد خرید'),
                                                                  onPressed:
                                                                      () {
                                                                    if (context
                                                                            .read<
                                                                                Cart>()
                                                                            .getCartItem
                                                                            .firstWhereOrNull((element) =>
                                                                                element.productId ==
                                                                                product.productId) !=
                                                                        null) {
                                                                      context
                                                                          .read<
                                                                              Wish>()
                                                                          .removeItem(
                                                                              product.productId);
                                                                      Navigator.pop(
                                                                          context);
                                                                    } else {
                                                                      context.read<Cart>().addToCartItem(
                                                                          product
                                                                              .name,
                                                                          product
                                                                              .price,
                                                                          1,
                                                                          product
                                                                              .qntty,
                                                                          product
                                                                              .imageUrl,
                                                                          product
                                                                              .productId,
                                                                          product
                                                                              .suppId);

                                                                      context
                                                                          .read<
                                                                              Wish>()
                                                                          .removeItem(
                                                                              product.productId);
                                                                      Navigator.pop(
                                                                          context);
                                                                    }
                                                                  }),
                                                              CupertinoActionSheetAction(
                                                                child: const Text(
                                                                    'حذف آیتم'),
                                                                onPressed: () {
                                                                  context
                                                                      .read<
                                                                          Wish>()
                                                                      .removeItem(
                                                                          product
                                                                              .productId);
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                              )
                                                            ],
                                                            cancelButton:
                                                                TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child:
                                                                        const Text(
                                                                      'لغو',
                                                                    )),
                                                          ),
                                                        );
                                                      },
                                                      icon: const Icon(
                                                        Icons.delete_forever,
                                                        size: 18,
                                                      )))
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
                      : const Center(
                          child: AutoSizeText(
                            'لیست علاقه مندی های شما خالی است !',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 30),
                          ),
                        );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
