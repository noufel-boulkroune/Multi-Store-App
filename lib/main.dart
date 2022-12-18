import 'package:flutter/material.dart';
import 'package:multi_store_app/screens/customer_home_screen.dart';
import 'package:multi_store_app/screens/supplier_home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SupplierHomeScreen(),
    );
  }
}
