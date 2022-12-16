import 'package:flutter/material.dart';
import 'package:multi_store_app/screens/customer_home_screen.dart';
import 'package:multi_store_app/widgets/appbar_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const AppBarTitle(title: "Cart"),
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
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CustomerHomeScreen(),
                    ));
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
            Container(
              height: 40,
              width: MediaQuery.of(context).size.width * .4,
              decoration: BoxDecoration(
                  color: const Color(0xFFF2B705),
                  borderRadius: BorderRadius.circular(25)),
              child: MaterialButton(
                onPressed: () {},
                child: const Text("CHECK OUT"),
              ),
            )
          ],
        ),
      ),
    );
  }
}