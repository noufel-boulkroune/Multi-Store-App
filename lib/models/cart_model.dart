import 'package:flutter/material.dart';
import 'package:multi_store_app/providers/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

import '../providers/wishlist_provider.dart';
import '../providers/products_class.dart';
import '../widgets/alert_dialog.dart';

class CartModel extends StatelessWidget {
  const CartModel({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        child: SizedBox(
          height: 100,
          child: Row(
            children: [
              SizedBox(
                  height: 100,
                  width: 100,
                  child: Image.network(
                    product.imagesUrl.first,
                    fit: BoxFit.cover,
                  )),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.name,
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
                            product.price.toStringAsFixed(2) + " \$",
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          ),
                          Container(
                            height: 35,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  product.quentity == 1
                                      ? IconButton(
                                          onPressed: () {
                                            GeneralAlertDialog.showMyDialog(
                                                context: context,
                                                title: "Remove item from cart",
                                                contet: context
                                                            .read<
                                                                WishlistProvider>()
                                                            .wishlistList
                                                            .firstWhereOrNull(
                                                              (wishlistProduct) =>
                                                                  wishlistProduct
                                                                      .documentId ==
                                                                  product
                                                                      .documentId,
                                                            ) ==
                                                        null
                                                    ? "Do you want to add this product to wishlist?"
                                                    : "Do you want to remove this item from cart?",
                                                tabYes: () {
                                                  context
                                                              .read<
                                                                  WishlistProvider>()
                                                              .wishlistList
                                                              .firstWhereOrNull(
                                                                (wishlistProduct) =>
                                                                    wishlistProduct
                                                                        .documentId ==
                                                                    product
                                                                        .documentId,
                                                              ) ==
                                                          null
                                                      ? context
                                                          .read<
                                                              WishlistProvider>()
                                                          .addWishItem(
                                                              product.name,
                                                              product.price,
                                                              1,
                                                              product.inStock,
                                                              product.imagesUrl,
                                                              product
                                                                  .documentId,
                                                              product
                                                                  .supplierId)
                                                      : null;
                                                  context
                                                      .read<CartProvider>()
                                                      .removeItem(product);
                                                  Navigator.pop(context);
                                                },
                                                tabNo: () {
                                                  Navigator.pop(context);
                                                });
                                          },
                                          icon:
                                              const Icon(Icons.delete_forever))
                                      : IconButton(
                                          onPressed: () {
                                            context
                                                .read<CartProvider>()
                                                .decrementQuentity(product);
                                          },
                                          icon: const Icon(Icons.remove)),
                                  Text(
                                    product.quentity.toString(),
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            product.quentity == product.inStock
                                                ? Colors.red
                                                : Colors.black),
                                  ),
                                  IconButton(
                                      onPressed: product.quentity ==
                                              product.inStock
                                          ? null
                                          : () {
                                              context
                                                  .read<CartProvider>()
                                                  .incrementQuentity(product);
                                            },
                                      icon: const Icon(Icons.add)),
                                ]),
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
