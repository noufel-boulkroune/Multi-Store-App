import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

import '../providers/cart_provider.dart';
import '../providers/products_class.dart';
import '../providers/wishlist_provider.dart';
import '../widgets/alert_dialog.dart';

class WishlistModel extends StatelessWidget {
  const WishlistModel({
    Key? key,
    required this.wishlistProduct,
  }) : super(key: key);

  final Product wishlistProduct;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        child: SizedBox(
          height: 110,
          child: Row(
            children: [
              SizedBox(
                  height: 100,
                  width: 100,
                  child: Image.network(
                    wishlistProduct.imagesUrl.first,
                    fit: BoxFit.cover,
                  )),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        wishlistProduct.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            wishlistProduct.price.toStringAsFixed(2) + " \$",
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          ),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    GeneralAlertDialog.showMyDialog(
                                        context: context,
                                        title: "Clear wishlist",
                                        contet:
                                            "Are you sure you want to remove tis product from wishlist?",
                                        tabNo: () {
                                          Navigator.pop(context);
                                        },
                                        tabYes: () {
                                          context
                                              .read<WishlistProvider>()
                                              .removeItem(wishlistProduct);
                                          Navigator.pop(context);
                                        });
                                  },
                                  icon: Icon(Icons.delete_forever)),
                              context
                                          .watch<CartProvider>()
                                          .productsList
                                          .firstWhereOrNull(
                                            (cartProduct) =>
                                                cartProduct.documentId ==
                                                wishlistProduct.documentId,
                                          ) !=
                                      null
                                  ? SizedBox()
                                  : SizedBox(
                                      child: IconButton(
                                          onPressed: () {
                                            context
                                                .read<CartProvider>()
                                                .addItem(
                                                    wishlistProduct.name,
                                                    wishlistProduct.price,
                                                    1,
                                                    wishlistProduct.inStock,
                                                    wishlistProduct.imagesUrl,
                                                    wishlistProduct.documentId,
                                                    wishlistProduct.supplierId);
                                            context
                                                .read<WishlistProvider>()
                                                .removeFromWishlist(
                                                    wishlistProduct.documentId);
                                          },
                                          icon: Icon(Icons.add_shopping_cart)),
                                    ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
