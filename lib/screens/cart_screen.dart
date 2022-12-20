import 'package:flutter/material.dart';
import 'package:multi_store_app/screens/customer_home_screen.dart';
import 'package:multi_store_app/widgets/appbar_widget.dart';

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
          body: Center(
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
          ),
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
                  color: Color(0xFFF2B705),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
