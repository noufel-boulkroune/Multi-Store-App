import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/wichlist_provider.dart';
import '../screens/minor_screen/product_detail_screen.dart';
import 'package:collection/collection.dart';

import '../widgets/snackbar.dart';

class ProductDataModel extends StatelessWidget {
  final dynamic data;

  const ProductDataModel({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    dynamic product = data;
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(product: data),
          )),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                child: Container(
                  constraints:
                      const BoxConstraints(maxHeight: 250, minHeight: 100),
                  child: Image(image: NetworkImage(data["productImages"][0])),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: Text(
                  data["productName"],
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.left,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                )),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      data["price"].toStringAsFixed(2) + " \$",
                      style: TextStyle(
                        color: Colors.red.shade600,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    data["supplierId"] == FirebaseAuth.instance.currentUser!.uid
                        ? IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.edit),
                            color: Colors.red,
                          )
                        : IconButton(
                            onPressed: () {
                              context
                                          .read<WishlistProvider>()
                                          .wishlistList
                                          .firstWhereOrNull(
                                            (wishlistProduct) =>
                                                wishlistProduct.documentId ==
                                                product["productId"],
                                          ) !=
                                      null
                                  ? context
                                      .read<WishlistProvider>()
                                      .removeFromWishlist(product["productId"])
                                  : context
                                      .read<WishlistProvider>()
                                      .addWishItem(
                                          product["productName"],
                                          product["price"],
                                          1,
                                          product["inStock"],
                                          product["productImages"],
                                          product["productId"],
                                          product["supplierId"]);
                            },
                            icon: context
                                        .watch<WishlistProvider>()
                                        .wishlistList
                                        .firstWhereOrNull(
                                          (wishlistProduct) =>
                                              wishlistProduct.documentId ==
                                              product["productId"],
                                        ) !=
                                    null
                                ? const Icon(
                                    Icons.favorite,
                                    size: 30,
                                    color: Colors.red,
                                  )
                                : const Icon(
                                    Icons.favorite_border_outlined,
                                    size: 30,
                                    color: Colors.red,
                                  )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
