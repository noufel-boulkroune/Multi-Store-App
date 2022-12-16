import 'package:flutter/material.dart';

import '../../widgets/appbar_widget.dart';

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
          leading: const AppBarBackButton(),
          title: AppBarTitle(title: subCategoryName)),
      body: Center(
        child: Text(mainCategoryName),
      ),
    );
  }
}
