import 'package:flutter/material.dart';
import 'package:multi_store_app/auth/customer_signup_screen.dart';
import 'package:multi_store_app/screens/customer_home_screen.dart';
import 'package:multi_store_app/screens/supplier_home_screen.dart';
import 'package:multi_store_app/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';

import 'auth/customer_login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
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
        CustomerLoginScreen.routeName: (context) => const CustomerLoginScreen()
      },
    );
  }
}
