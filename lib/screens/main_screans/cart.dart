import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multi_store_app/providers/cart_provider.dart';
import 'package:multi_store_app/widgets/alirt_dialog.dart';
import 'package:provider/provider.dart';
import '../../providers/wish_provider.dart';
import '../../widgets/reuseable_bottun.dart';
import '../../widgets/snackbarr.dart';
import 'package:collection/collection.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key, this.backButtom});

  final Widget? backButtom;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final GlobalKey<ScaffoldMessengerState> _globalKey =
      GlobalKey<ScaffoldMessengerState>();

  void replacePage() {
    Navigator.canPop(context)
        ? Navigator.pop(context)
        : Navigator.pushReplacementNamed(context, '/customer_screen',
            arguments: FirebaseAuth.instance.currentUser!.isAnonymous
                ? 'anonymous'
                : 'customer');
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
                  "سبدخرید",
                  style: TextStyle(color: Colors.black87),
                ),
                leading: widget.backButtom,
                actions: [
                  IconButton(
                      onPressed: () {
                        context.read<Cart>().count == 0
                            ? Snackbar(
                                    key: _globalKey,
                                    content: 'سبد خرید شما خالی هست !')
                                .showsnackBar()
                            : CuperAlertDialog(
                                    context: context,
                                    agree: 'بلی',
                                    desAgree: 'نخیر',
                                    agreeFun: () {
                                      context.read<Cart>().clearCart();
                                      Navigator.pop(context);
                                    },
                                    desAgreeFun: (() => Navigator.pop(context)),
                                    title: 'پاک کردن سبد',
                                    descreption:
                                        'آیا مطمعین هستید که مخواهید تمام آیتم های سبد خرید را حذف کنید؟')
                                .showAlertDialog();
                      },
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
                            final product = cart.getCartItem[index];
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
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Grunge',
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
                                                              // context
                                                              //     .read<Cart>()
                                                              //     .removeItem(
                                                              //         product);
                                                              showCupertinoModalPopup<
                                                                  void>(
                                                                context:
                                                                    context,
                                                                builder: (BuildContext
                                                                        context) =>
                                                                    CupertinoActionSheet(
                                                                  title: const Text(
                                                                      'حدف آیتم'),
                                                                  message:
                                                                      const Text(
                                                                          'آیا مطمعین هستید که میخواهید این آیتم رو حذف کنید؟'),
                                                                  actions: <CupertinoActionSheetAction>[
                                                                    CupertinoActionSheetAction(
                                                                        child: const Text(
                                                                            'انتقال به موردعلاقه ها'),
                                                                        onPressed:
                                                                            () {
                                                                          if (context.read<Wish>().getWishItem.firstWhereOrNull((element) => element.productId == product.productId) !=
                                                                              null) {
                                                                            context.read<Cart>().removeItem(product);
                                                                            Navigator.pop(context);
                                                                          } else {
                                                                            context.read<Wish>().addToWishItem(
                                                                                product.name,
                                                                                product.price,
                                                                                1,
                                                                                product.qntty,
                                                                                product.imageUrl,
                                                                                product.productId,
                                                                                product.suppId);

                                                                            context.read<Cart>().removeItem(product);
                                                                            Navigator.pop(context);
                                                                          }
                                                                        }),
                                                                    CupertinoActionSheetAction(
                                                                      child: const Text(
                                                                          'حذف آیتم'),
                                                                      onPressed:
                                                                          () {
                                                                        context
                                                                            .read<Cart>()
                                                                            .removeItem(product);
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                    )
                                                                  ],
                                                                  cancelButton:
                                                                      TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child:
                                                                              const Text(
                                                                            'لغو',
                                                                          )),
                                                                ),
                                                              );
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
                      Row(
                        children: [
                          const Text(
                            "مجموعه : ",
                            style: TextStyle(fontSize: 22),
                          ),
                          Text(
                            '${context.watch<Cart>().totalPrice.toStringAsFixed(4)} \$',
                            style: const TextStyle(
                                color: Colors.red,
                                fontSize: 22,
                                fontFamily: 'Grunge',
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
      ),
    );
  }
}
