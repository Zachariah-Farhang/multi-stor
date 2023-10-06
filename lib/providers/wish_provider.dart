import 'package:flutter/material.dart';

import '../models/product_model.dart';

class Wish extends ChangeNotifier {
  final List<Product> _list = [];

  List<Product> get getWishItem {
    return _list;
  }

  int get count {
    return _list.length;
  }

  void addToWishItem(
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

  void removeItem(String id) {
    _list.removeWhere((element) => element.productId == id);

    notifyListeners();
  }

  void clearWisList() {
    _list.clear();

    notifyListeners();
  }
}
