import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_app/widgets/appbar_widget.dart';

class CustomerOrdersScreen extends StatelessWidget {
  CustomerOrdersScreen({super.key});

  final Stream<QuerySnapshot> _orderStream = FirebaseFirestore.instance
      .collection("orders")
      .where("customerId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const AppBarTitle(title: "Orders"),
        leading: AppBarBackButton(
          color: Colors.black,
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _orderStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Material(
              color: Colors.white,
              child: Center(
                child: Image(
                  image: AssetImage("assets/svgs/loading-animation-blue.gif"),
                ),
              ),
            );
          }
          final order = snapshot.data!.docs;
          if (order.isEmpty) {
            return const Center(
              child: Text(
                "You Have Not \n\n Active Orders !",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }
          return ListView.builder(
              itemCount: order.length,
              itemBuilder: (context, index) => Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 1, color: Colors.lightBlueAccent),
                        borderRadius: BorderRadius.circular(15)),
                    child: ExpansionTile(
                      title: Container(
                        constraints: BoxConstraints(
                            maxHeight: 80, maxWidth: double.infinity),
                        child: Row(
                          children: [
                            Container(
                              constraints: const BoxConstraints(
                                  maxHeight: 80, maxWidth: 80),
                              child: Image.network(order[index]["orderImage"]),
                            ),
                            Flexible(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    order[index]["productName"],
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade600,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          "\$ ${order[index]["orderPrice"].toStringAsFixed(2)}"),
                                      Text(
                                          "x ${order[index]["orderQuantity"].toString()}")
                                    ],
                                  )
                                ],
                              ),
                            ))
                          ],
                        ),
                      ),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("See more .."),
                          Text(order[index]["deliveryStatus"])
                        ],
                      ),
                    ),
                  ));
        },
      ),
    );
  }
}
