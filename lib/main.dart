import 'package:flutter/material.dart';
import 'package:multi_store_app/auth/forgot_password.dart';
import 'package:multi_store_app/auth/update_password.dart';
//import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:multi_store_app/providers/cart_provider.dart';
import 'package:multi_store_app/screens/customer_screens/add_address.dart';
import 'package:multi_store_app/screens/customer_screens/address_list.dart';
import 'package:multi_store_app/screens/minor_screen/edit_product.dart';
import 'package:multi_store_app/screens/minor_screen/edit_store.dart';
import 'package:multi_store_app/screens/onboarding_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import '../auth/customer_signup_screen.dart';
import '../screens/customer_home_screen.dart';
import '../screens/supplier_home_screen.dart';
import '../screens/welcome_screen.dart';
import 'auth/customer_login_screen.dart';
import 'auth/supplier_login_screen.dart';
import 'auth/supplier_signup_screen.dart';
import 'constante/stripe_keys.dart';
import 'providers/wichlist_provider.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = stripePublishableKey;
  Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
  Stripe.urlScheme = 'flutterstripe';
  await Stripe.instance.applySettings();
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
      // initialRoute: OnboardingScreen.routeName,
      initialRoute: OnboardingScreen.routeName,
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
        EditStore.routeName: (context) => const EditStore(),
        EditProduct.routeName: (context) => const EditProduct(),
        AddAddress.routeName: (context) => const AddAddress(),
        AddressList.routeName: (context) => const AddressList(),
        ForgotPassword.routeName: (context) => const ForgotPassword(),
        UpdatePassword.routeName: (context) => const UpdatePassword(),
        OnboardingScreen.routeName: (context) => const OnboardingScreen(),
      },
    );
  }
}
