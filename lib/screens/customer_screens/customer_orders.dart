import 'package:flutter/material.dart';
import 'package:multi_store_app/widgets/appbar_widget.dart';

class CustomerOrdersScreen extends StatelessWidget {
  const CustomerOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const AppBarTitle(title: "Customer Orders"),
        leading: const AppBarBackButton(),
      ),
    );
  }
}
