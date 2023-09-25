class Product {
  String name;
  double price;
  int qty = 1;
  String qntty;
  List imageUrl;
  String productId;
  String suppId;
  Product({
    required this.name,
    required this.price,
    required this.qty,
    required this.qntty,
    required this.imageUrl,
    required this.productId,
    required this.suppId,
  });
  void increase() {
    qty++;
  }

  void decrease() {
    qty--;
  }
}
