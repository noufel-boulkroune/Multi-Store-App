import 'package:flutter/material.dart';
import 'package:multi_store_app/screens/dashboard_components/balance_screen.dart';
import 'package:multi_store_app/screens/dashboard_components/edit_business.dart';
import 'package:multi_store_app/screens/dashboard_components/manage_products_screen.dart';
import 'package:multi_store_app/screens/dashboard_components/my_store.dart';
import 'package:multi_store_app/screens/dashboard_components/statics_screen.dart';
import 'package:multi_store_app/screens/dashboard_components/supplier_orders_screen.dart';
import 'package:multi_store_app/widgets/appbar_widget.dart';

List<String> lable = [
  "my store",
  "orders",
  "edit profile",
  "manage products",
  "balance",
  "statics"
];

List<IconData> iconsList = [
  Icons.store,
  Icons.shop_2_outlined,
  Icons.edit,
  Icons.settings,
  Icons.attach_money,
  Icons.show_chart,
];

List<Widget> pages = [
  MyStoreScreen(),
  SupplierOrdersScreen(),
  EditBusinessScreen(),
  ManageProductsScreen(),
  BalanceScreen(),
  StaticsScreen()
];

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const AppBarTitle(title: "Dashboard"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, "/");
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: GridView.count(
            mainAxisSpacing: 30,
            crossAxisSpacing: 30,
            crossAxisCount: 2,
            children: List.generate(
                6,
                (index) => InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => pages[index],
                          )),
                      child: Card(
                        elevation: 25,
                        shadowColor: const Color(0xFF434A59),
                        color: const Color(0xFF434A59),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(
                                  iconsList[index],
                                  size: 50,
                                  color: Colors.lightBlueAccent,
                                ),
                                Text(
                                  lable[index].toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 2,
                                      fontFamily: "Acme",
                                      color: Colors.lightBlueAccent),
                                )
                              ]),
                        ),
                      ),
                    ))),
      ),
    );
  }
}
