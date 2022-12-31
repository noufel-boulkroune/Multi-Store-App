import 'package:flutter/material.dart';
import 'package:multi_store_app/providers/wishlist_provider.dart';
import 'package:multi_store_app/widgets/alert_dialog.dart';
import 'package:provider/provider.dart';

import '../../models/wishlist_model.dart';
import '/widgets/appbar_widget.dart';

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
              context.watch<WishlistProvider>().wishlistList.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        GeneralAlertDialog.showMyDialog(
                            context: context,
                            title: "Clear wishlist",
                            contet: "Are you sure you want to clear wishlist?",
                            tabNo: () {
                              Navigator.pop(context);
                            },
                            tabYes: () {
                              context.read<WishlistProvider>().clearWishlist();
                              Navigator.pop(context);
                            });
                      },
                      icon: const Icon(
                        Icons.delete_forever,
                        color: Colors.black,
                      ))
                  : SizedBox()
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
            return WishlistModel(wishlistProduct: wishlistProduct);
          },
        );
      },
    );
  }
}
