import 'package:flutter/material.dart';
import 'package:multi_store_app/providers/cart_provider.dart';
import 'package:provider/provider.dart';

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
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.delete_forever,
                    color: Colors.black,
                  ))
            ],
          ),
          body: Consumer<CartProvider>(
            builder: (_, cart, __) {
              return ListView.builder(
                itemCount: cart.count,
                itemBuilder: (context, index) {
                  final product = cart.productsList[index];
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          product.price.toStringAsFixed(2) +
                                              " \$",
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red),
                                        ),
                                        Container(
                                          height: 35,
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade200,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                product.quentity == 1
                                                    ? IconButton(
                                                        onPressed: () {},
                                                        icon: const Icon(Icons
                                                            .delete_forever))
                                                    : IconButton(
                                                        onPressed: () {
                                                          cart.decrement(
                                                              product);
                                                        },
                                                        icon: const Icon(
                                                            Icons.remove)),
                                                Text(
                                                  product.quentity.toString(),
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: product.quentity ==
                                                              product.inStock
                                                          ? Colors.red
                                                          : Colors.black),
                                                ),
                                                IconButton(
                                                    onPressed:
                                                        product.quentity ==
                                                                product.inStock
                                                            ? null
                                                            : () {
                                                                cart.increment(
                                                                    product);
                                                              },
                                                    icon:
                                                        const Icon(Icons.add)),
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
                },
              );
            },
          ),
          /*Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
          ),*/
          bottomSheet: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                const Text(
                  "Total : \$ ",
                  style: TextStyle(fontSize: 18),
                ),
                const Expanded(
                  child: Text(
                    "00.00",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.lightBlueAccent),
                  ),
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
