import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import '/screens/cart_screen.dart';
import '/screens/home_screen.dart';
import '/screens/profile_screen.dart';
import '/screens/stores_screen.dart';
import '../providers/cart_provider.dart';
import 'category_screen.dart';

class CustomerHomeScreen extends StatefulWidget {
  static const routeName = "customer_screen";
  const CustomerHomeScreen({super.key});

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> _tabs = [
    const HomeScreen(),
    const CategoryScreen(),
    StoresScreen(),
    const CartScreen(),
    ProfileScreen(
      documentId: FirebaseAuth.instance.currentUser!.uid,
    ),
    // ProfileScreen(documentId: "v1Wb04NL2mSXqwt2Xi6WOdNgyBi2")
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
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Category",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.shop),
            label: "Stores",
          ),
          BottomNavigationBarItem(
            icon: Badge(
                animationType: BadgeAnimationType.slide,
                badgeColor: Colors.lightBlueAccent,
                badgeContent: Text(context
                    .watch<CartProvider>()
                    .productsList
                    .length
                    .toString()),
                child: const Icon(Icons.shopping_cart)),
            label: "Cart",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
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
