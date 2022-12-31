import 'package:flutter/material.dart';
import 'package:multi_store_app/providers/cart_provider.dart';
import 'package:multi_store_app/providers/wichlist_provider.dart';
import 'package:multi_store_app/widgets/alert_dialog.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

import '../../widgets/snackbar.dart';
import '/screens/customer_home_screen.dart';
import '/widgets/appbar_widget.dart';

import '/widgets/blue_button.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey.shade200,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title: const AppBarTitle(title: "Wishlist"),
            leading: AppBarBackButton(color: Colors.black),
            actions: [
              // context.watch<WishlistProvider>().wishlistList.isNotEmpty
              //     ? IconButton(
              //         onPressed: () {
              //           GeneralAlertDialog.showMyDialog(
              //               context: context,
              //               title: "Clear cart",
              //               contet: "Are you sure you want to clear cart?",
              //               tabNo: () {
              //                 Navigator.pop(context);
              //               },
              //               tabYes: () {
              //                 context.read<WishlistProvider>().clearWishlist();
              //                 Navigator.pop(context);
              //               });
              //         },
              //         icon: const Icon(
              //           Icons.delete_forever,
              //           color: Colors.black,
              //         ))
              //     : SizedBox()
            ],
          ),
          body: context.watch<WishlistProvider>().wishlistList.isNotEmpty
              ? const WishlistItems()
              : const EmptyWishlist(),
        ),
      ),
    );
  }
}

class EmptyWishlist extends StatelessWidget {
  const EmptyWishlist({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child:
          Column(mainAxisAlignment: MainAxisAlignment.center, children: const [
        Text(
          "Your Wishlist Is Empty!",
          style: TextStyle(fontSize: 30),
        ),
        SizedBox(
          height: 50,
        ),
      ]),
    );
  }
}

class WishlistItems extends StatelessWidget {
  const WishlistItems({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<WishlistProvider>(
      builder: (_, wishlist, __) {
        return ListView.builder(
          itemCount: wishlist.count,
          itemBuilder: (context, index) {
            final wishlistProduct = wishlist.wishlistList[index];
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    wishlistProduct.price.toStringAsFixed(2) +
                                        " \$",
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
                                                    "Are you sure you want to clear wishlist?",
                                                tabNo: () {
                                                  Navigator.pop(context);
                                                },
                                                tabYes: () {
                                                  context
                                                      .read<WishlistProvider>()
                                                      .removeItem(
                                                          wishlistProduct);
                                                  Navigator.pop(context);
                                                });
                                          },
                                          icon: Icon(Icons.delete_forever)),
                                      context
                                                  .watch<CartProvider>()
                                                  .productsList
                                                  .firstWhereOrNull(
                                                    (cartProduct) =>
                                                        cartProduct
                                                            .documentId ==
                                                        wishlistProduct
                                                            .documentId,
                                                  ) !=
                                              null
                                          ? SizedBox()
                                          : SizedBox(
                                              child: IconButton(
                                                  onPressed: () {
                                                    context
                                                        .read<CartProvider>()
                                                        .addItem(
                                                            wishlistProduct
                                                                .name,
                                                            wishlistProduct
                                                                .price,
                                                            1,
                                                            wishlistProduct
                                                                .inStock,
                                                            wishlistProduct
                                                                .imagesUrl,
                                                            wishlistProduct
                                                                .documentId,
                                                            wishlistProduct
                                                                .supplierId);
                                                    context
                                                        .read<
                                                            WishlistProvider>()
                                                        .removeFromWishlist(
                                                            wishlistProduct
                                                                .documentId);
                                                  },
                                                  icon: Icon(
                                                      Icons.add_shopping_cart)),
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
          },
        );
      },
    );
  }
}
