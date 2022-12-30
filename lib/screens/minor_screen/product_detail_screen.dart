import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:multi_store_app/screens/minor_screen/visit_store_screen.dart';

import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../../models/product_data_model.dart';
import '../../widgets/blue_button.dart';
import 'full_screen_view.dart';

class ProductDetailScreen extends StatefulWidget {
  static const routeName = "product_detail_screen";
  final dynamic product;
  ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late List<dynamic> imagesList = widget.product["productImages"];
  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final Stream<QuerySnapshot> _productsStream = FirebaseFirestore.instance
        .collection('products')
        .where("mainCategory", isEqualTo: product["mainCategory"])
        .snapshots();
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 50),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FullScreenView(
                          imagesList: imagesList,
                        ),
                      ));
                },
                child: Stack(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .45,
                      // width: double.infinity,
                      child: Swiper(
                          pagination: const SwiperPagination(
                            builder: SwiperPagination.fraction,
                          ),
                          itemBuilder: (context, index) {
                            return Image(
                              image: NetworkImage(imagesList[index]),
                              fit: BoxFit.cover,
                            );
                          },
                          itemCount: imagesList.length),
                    ),
                    Positioned(
                        top: 20,
                        left: 10,
                        child: CircleAvatar(
                          backgroundColor: Colors.lightBlueAccent,
                          child: IconButton(
                              color: Colors.white,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.arrow_back_ios_new)),
                        )),
                    Positioned(
                        top: 20,
                        right: 10,
                        child: CircleAvatar(
                          backgroundColor: Colors.lightBlueAccent,
                          child: IconButton(
                              color: Colors.white,
                              onPressed: () {},
                              icon: Icon(Icons.share)),
                        )),
                  ],
                ),
              ),
              Text(
                product["productName"],
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "USD",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        product["price"].toString(),
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.favorite_border_outlined,
                        size: 30,
                        color: Colors.red,
                      )),
                ],
              ),
              Text(
                product["inStock"].toString() + " pieces available in stock",
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const ProductDetailsHeader(
                lable: "   Item Description   ",
              ),
              Text(
                product["productDescription"],
                style: TextStyle(
                  color: Colors.blueGrey.shade800,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const ProductDetailsHeader(
                lable: "  Recommended Items  ",
              ),
              SizedBox(
                child: StreamBuilder<QuerySnapshot>(
                  stream: _productsStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: Text("Waiting"));
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

                    return SingleChildScrollView(
                      child: StaggeredGridView.countBuilder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
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
                      ),
                    );
                  },
                ),
              ),
            ]),
          ),
        ),
        bottomSheet: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VisitStoreScreen(
                                  supplierId: product["supplierId"]),
                            ));
                      },
                      icon: Icon(Icons.store)),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.shopping_cart),
                  ),
                ],
              ),
              BlueButton(
                lable: 'ADD TO CART',
                color: Colors.lightBlueAccent,
                width: .5,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductDetailsHeader extends StatelessWidget {
  final String lable;
  const ProductDetailsHeader({
    Key? key,
    required this.lable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 50,
            height: 40,
            child: Divider(
              thickness: 3,
              height: 2,
              color: Colors.lightBlueAccent,
            ),
          ),
          Text(
            lable,
            style: const TextStyle(
              color: Colors.lightBlueAccent,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
              width: 50,
              height: 40,
              child: Divider(
                thickness: 3,
                height: 2,
                color: Colors.lightBlueAccent,
              )),
        ],
      ),
    );
  }
}