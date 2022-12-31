class Product {
  String name;
  double price;
  int quentity = 1;
  int inStock;
  List imagesUrl;
  String documentId;
  String supplierId;
  Product({
    required this.name,
    required this.price,
    required this.quentity,
    required this.inStock,
    required this.imagesUrl,
    required this.documentId,
    required this.supplierId,
  });

  void increaseQuentity() {
    quentity++;
  }

  void decreaseQuentity() {
    quentity--;
  }
}
