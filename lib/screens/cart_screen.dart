import 'package:flutter/material.dart';
import 'package:multi_store_app/providers/cart_provider.dart';
import 'package:multi_store_app/widgets/alert_dialog.dart';
import 'package:provider/provider.dart';

import '../models/cart_model.dart';
import '../screens/customer_home_screen.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/blue_button.dart';

class CartScreen extends StatefulWidget {
  final Widget? back;
  const CartScreen({super.key, this.back});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey.shade200,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title: const AppBarTitle(title: "Cart"),
            leading: widget.back,
            actions: [
              context.watch<CartProvider>().productsList.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        GeneralAlertDialog.showMyDialog(
                            context: context,
                            title: "Clear cart",
                            contet: "Are you sure you want to clear cart?",
                            tabNo: () {
                              Navigator.pop(context);
                            },
                            tabYes: () {
                              context.read<CartProvider>().clearCart();
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
          body: context.watch<CartProvider>().productsList.isNotEmpty
              ? const CartItems()
              : const EmptyCart(),
          bottomSheet: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                const Text(
                  "Total : \$ ",
                  style: TextStyle(fontSize: 18),
                ),
                Consumer<CartProvider>(
                  builder: (_, cart, __) {
                    return Expanded(
                      child: Text(
                        cart.totalPrice.toString(),
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.lightBlueAccent),
                      ),
                    );
                  },
                ),
                BlueButton(
                  lable: 'CHECK OUT',
                  onPressed: () {},
                  width: .4,
                  color: const Color(0xFFF2B705),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EmptyCart extends StatelessWidget {
  const EmptyCart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text(
          "Your Cart Is Empty!",
          style: TextStyle(fontSize: 30),
        ),
        const SizedBox(
          height: 50,
        ),
        Material(
          color: Colors.lightBlueAccent,
          borderRadius: BorderRadius.circular(25),
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width * .6,
            onPressed: () {
              Navigator.canPop(context)
                  ? Navigator.pop(context)
                  : Navigator.pushReplacementNamed(
                      context, CustomerHomeScreen.routeName);
            },
            child: const Text(
              "continue shopping",
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ),
        )
      ]),
    );
  }
}

class CartItems extends StatelessWidget {
  const CartItems({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (_, cart, __) {
        return ListView.builder(
          itemCount: cart.count,
          itemBuilder: (context, index) {
            final product = cart.productsList[index];
            return CartModel(
              product: product,
            );
          },
        );
      },
    );
  }
}
