import 'package:flutter/material.dart';
import 'package:multi_store_app/widgets/appbar_widget.dart';

class BalanceScreen extends StatelessWidget {
  const BalanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: AppBarTitle(title: "Balnce Screen"),
        leading: AppBarBackButton(),
      ),
    );
  }
}
