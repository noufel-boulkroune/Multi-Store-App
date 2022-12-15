import 'package:flutter/material.dart';

class SubCategoryProducts extends StatelessWidget {
  final String subCategoryName;
  final String mainCategoryName;
  const SubCategoryProducts(
      {super.key,
      required this.subCategoryName,
      required this.mainCategoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
              )),
          title: Text(
            subCategoryName,
            style: const TextStyle(color: Colors.black, letterSpacing: 2),
          )),
      body: Center(
        child: Text(mainCategoryName),
      ),
    );
  }
}
