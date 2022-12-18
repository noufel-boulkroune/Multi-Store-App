import 'package:flutter/material.dart';
import 'package:multi_store_app/widgets/appbar_widget.dart';

class StaticsScreen extends StatelessWidget {
  const StaticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: AppBarTitle(title: "Statics Screen"),
        leading: AppBarBackButton(),
      ),
    );
  }
}
