import 'package:flutter/material.dart';
import 'package:multi_store_app/utilities/category_list.dart';

import '../minor_screen/sub_category_products.dart';

class MenCategoryScreen extends StatelessWidget {
  const MenCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Text(
            "Men",
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 1.5),
          ),
        ),
        SizedBox(
          height: size.height * 0.68,
          child: GridView.count(
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
            crossAxisCount: 3,
            children: List.generate(men.length, (index) {
              return SizedBox(
                height: 200,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SubCategoryProducts(
                            subCategoryName: men[index],
                            mainCategoryName: 'men',
                          ),
                        ));
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        height: 75,
                        width: 75,
                        child: Image.asset(
                          "assets/images/men/men$index.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text(men[index])
                    ],
                  ),
                ),
              );
            }),
          ),
        )
      ],
    );
  }
}
