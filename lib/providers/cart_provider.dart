import 'package:flutter/foundation.dart';
import 'package:multi_store_app/providers/products_class.dart';

class CartProvider extends ChangeNotifier {
  final List<Product> _productsList = [];

  List<Product> get productsList {
    return _productsList;
  }

  int get count {
    return _productsList.length;
  }

  double get totalPrice {
    double total = 0;
    for (var item in _productsList) {
      total += item.price * item.quentity;
    }
    return total;
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

  void incrementQuentity(Product product) {
    product.increaseQuentity();
    notifyListeners();
  }

  void decrementQuentity(Product product) {
    product.decreaseQuentity();
    notifyListeners();
  }

  void removeItem(Product product) {
    _productsList.remove(product);
    notifyListeners();
  }

  void clearCart() {
    _productsList.clear();
    notifyListeners();
  }
}
