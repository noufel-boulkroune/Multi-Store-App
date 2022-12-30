import 'package:flutter/material.dart';
import 'package:multi_store_app/screens/dashboard_screen.dart';
import 'package:multi_store_app/screens/home_screen.dart';
import 'package:multi_store_app/screens/stores_screen.dart';
import 'package:multi_store_app/screens/upload_products_screen.dart';

import 'category_screen.dart';

class SupplierHomeScreen extends StatefulWidget {
  static const routeName = "Supplier_screen";
  const SupplierHomeScreen({super.key});

  @override
  State<SupplierHomeScreen> createState() => _SupplierHomeScreenState();
}

class _SupplierHomeScreenState extends State<SupplierHomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> _tabs = [
    const HomeScreen(),
    const CategoryScreen(),
    StoresScreen(),
    const DashboardScreen(),
    const UploadProductsScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.lightBlueAccent,
        unselectedItemColor: Colors.grey,
        elevation: 0,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Category",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shop),
            label: "Stores",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.upload),
            label: "Upload",
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
