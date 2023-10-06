import 'package:flutter/material.dart';

import '../models/product_model.dart';

class Cart extends ChangeNotifier {
  final List<Product> _list = [];

  List<Product> get getCartItem {
    return _list;
  }

  int get count {
    return _list.length;
  }

  double get totalPrice {
    double total = 0.0;
    for (var item in _list) {
      total += item.price * item.qty;
    }
    return total;
  }

  void addToCartItem(
    String name,
    double price,
    int qty,
    String qntty,
    List imageUrl,
    String productId,
    String suppId,
  ) {
    final product = Product(
        name: name,
        price: price,
        qty: qty,
        qntty: qntty,
        imageUrl: imageUrl,
        productId: productId,
        suppId: suppId);
    _list.add(product);

    notifyListeners();
  }

  void increment(Product product) {
    product.increase();

    notifyListeners();
  }

  void decrement(Product product) {
    product.decrease();

    notifyListeners();
  }

  void removeItem(Product product) {
    _list.remove(product);

    notifyListeners();
  }

  void clearCart() {
    _list.clear();

    notifyListeners();
  }
}
