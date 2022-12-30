import 'package:flutter/material.dart';

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

  void increase() {
    quentity++;
  }

  void decrease() {
    quentity--;
  }
}

class CartProvider extends ChangeNotifier {
  final List<Product> _productsList = [];

  List<Product> get productsList {
    return _productsList;
  }

  int get count {
    return _productsList.length;
  }

  void addItem(
    String name,
    double price,
    int quentity,
    int inStock,
    List imagesUrl,
    String documentId,
    String supplierId,
  ) {
    final product = Product(
        name: name,
        price: price,
        quentity: quentity,
        inStock: inStock,
        imagesUrl: imagesUrl,
        documentId: documentId,
        supplierId: supplierId);
    _productsList.add(product);
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
}
