import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_app/widgets/appbar_widget.dart';

class StaticsScreen extends StatelessWidget {
  StaticsScreen({super.key});
  final Stream<QuerySnapshot> _ordersStream = FirebaseFirestore.instance
      .collection('orders')
      .where("supplierId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const AppBarTitle(title: "Statics Screen"),
        leading: AppBarBackButton(
          color: Colors.black,
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _ordersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
          final data = snapshot.data!.docs;
          if (data.isEmpty) {
            return const Center(
              child: Text(
                "This category \n has no items yet !",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }
          num itemCount = 0;
          for (var item in data) {
            itemCount += item["orderQuantity"];
          }

          double totalPrice = 0;
          for (var item in data) {
            totalPrice += item["orderQuantity"] * item["orderPrice"];
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                StaticsModel(
                  lable: 'Sold out',
                  value: data.length,
                ),
                StaticsModel(
                  lable: 'Item count',
                  value: itemCount,
                ),
                StaticsModel(
                  lable: 'Total balance',
                  value: totalPrice.toStringAsFixed(2),
                ),
                SizedBox()
              ],
            ),
          );
        },
      ),
    );
  }
}

class StaticsModel extends StatelessWidget {
  final String lable;
  final dynamic value;
  StaticsModel({
    Key? key,
    required this.lable,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 60,
          width: MediaQuery.of(context).size.width * .55,
          decoration: const BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25))),
          child: Center(
            child: Text(
              lable.toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ),
        Container(
          height: 90,
          width: MediaQuery.of(context).size.width * .55,
          decoration: BoxDecoration(
              color: Colors.blueGrey.shade100,
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25))),
          child: Center(
            child: Text(
              value.toString(),
              style: const TextStyle(
                  color: Colors.pink,
                  fontSize: 40,
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }
}
