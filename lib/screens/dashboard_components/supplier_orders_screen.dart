import 'package:flutter/material.dart';
import 'package:multi_store_app/widgets/appbar_widget.dart';

class SupplierOrdersScreen extends StatelessWidget {
  const SupplierOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const AppBarTitle(title: "Supplier Orders"),
        leading: AppBarBackButton(
          color: Colors.black,
        ),
      ),
    );
  }
}
