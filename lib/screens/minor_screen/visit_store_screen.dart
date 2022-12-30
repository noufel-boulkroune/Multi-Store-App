import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../../models/product_data_model.dart';

class VisirStoreScreen extends StatelessWidget {
  final String supplierId;
  const VisirStoreScreen({super.key, required this.supplierId});

  @override
  Widget build(BuildContext context) {
    CollectionReference suppliers =
        FirebaseFirestore.instance.collection('suppliers');

    final Stream<QuerySnapshot> productsStream = FirebaseFirestore.instance
        .collection('products')
        .where("supplierId", isEqualTo: supplierId)
        .snapshots();

    return FutureBuilder<DocumentSnapshot>(
      future: suppliers.doc(supplierId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
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

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
            appBar: AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 4,
                          color: Colors.lightBlueAccent,
                        ),
                        borderRadius: BorderRadius.circular(15)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        data["storeLogo"],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          data["storeName"].toString().toUpperCase(),
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 35,
                          width: MediaQuery.of(context).size.width * .3,
                          decoration: BoxDecoration(
                              color: Colors.lightBlueAccent.withOpacity(.7),
                              border: Border.all(width: 1, color: Colors.white),
                              borderRadius: BorderRadius.circular(25)),
                          child: Center(
                              child: Text(
                            "FOLLOW",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )),
                        )
                      ],
                    ),
                  )
                ],
              ),
              toolbarHeight: 100,
              flexibleSpace: Image.asset(
                "assets/images/inapp/coverimage.jpg",
                fit: BoxFit.cover,
              ),
            ),
            body: StreamBuilder<QuerySnapshot>(
              stream: productsStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: Image(
                      image:
                          AssetImage("assets/svgs/loading-animation-blue.gif"),
                    ),
                  );
                }
                final data = snapshot.data!.docs;
                if (data.isEmpty) {
                  return const Center(
                    child: Text(
                      "This stored \n has no items yet !",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 26,
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }

                return StaggeredGridView.countBuilder(
                  itemCount: data.length,
                  crossAxisCount: 2,
                  itemBuilder: (context, index) {
                    return ProductDataModel(
                      data: data[index],
                    );
                  },
                  staggeredTileBuilder: (index) {
                    return const StaggeredTile.fit(1);
                  },
                );
              },
            ),
          );
        }

        return const Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Image(
              image: AssetImage("assets/svgs/loading-animation-blue.gif"),
            ),
          ),
        );
      },
    );
  }
}
