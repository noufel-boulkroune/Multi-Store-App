import 'package:flutter/material.dart';
import 'package:multi_store_app/providers/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import '../auth/customer_signup_screen.dart';
import '../screens/customer_home_screen.dart';
import '../screens/supplier_home_screen.dart';
import '../screens/welcome_screen.dart';
import 'auth/customer_login_screen.dart';
import 'auth/supplier_login_screen.dart';
import 'auth/supplier_signup_screen.dart';
import 'providers/wishlist_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => CartProvider(),
    ),
    ChangeNotifierProvider(
      create: (_) => WishlistProvider(),
    )
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const WelcomeScreen(),
        CustomerHomeScreen.routeName: (context) => const CustomerHomeScreen(),
        SupplierHomeScreen.routeName: (context) => const SupplierHomeScreen(),
        CustomerSignupScreen.routeName: (context) =>
            const CustomerSignupScreen(),
        CustomerLoginScreen.routeName: (context) => const CustomerLoginScreen(),
        SupplierSignupScreen.routeName: (context) =>
            const SupplierSignupScreen(),
        SupplierLoginScreen.routeName: (context) => const SupplierLoginScreen(),
      },
    );
  }
}
