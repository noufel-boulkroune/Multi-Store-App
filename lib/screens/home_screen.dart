import 'package:flutter/material.dart';

import '../widgets/custom_search_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 9,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: const CustomSearchBar(),
          bottom: const TabBar(
              isScrollable: true,
              indicatorColor: Colors.blue,
              indicatorWeight: 1,
              labelStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              tabs: [
                RepeatedTab(label: 'Men'),
                RepeatedTab(label: 'Women'),
                RepeatedTab(label: 'Shoes'),
                RepeatedTab(label: 'Bags'),
                RepeatedTab(label: 'Electronics'),
                RepeatedTab(label: 'Accessories'),
                RepeatedTab(label: 'Home & Garden'),
                RepeatedTab(label: 'Kisds'),
                RepeatedTab(label: 'Beauty'),
              ]),
        ),
        body: const TabBarView(children: [
          Center(
            child: Text("Men Screen"),
          ),
          Center(
            child: Text("Women Screen"),
          ),
          Center(
            child: Text("Shoes Screen"),
          ),
          Center(
            child: Text("Bags Screen"),
          ),
          Center(
            child: Text("Electronics Screen"),
          ),
          Center(
            child: Text("Accessories Screen"),
          ),
          Center(
            child: Text("Home & Garden Screen"),
          ),
          Center(
            child: Text("Kids Screen"),
          ),
          Center(
            child: Text("Beauty Screen"),
          ),
        ]),
      ),
    );
  }
}

class RepeatedTab extends StatelessWidget {
  final String label;
  const RepeatedTab({
    Key? key,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text(
        label,
        style: TextStyle(color: Colors.grey.shade600),
      ),
    );
  }
}
