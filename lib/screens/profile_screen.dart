import 'package:flutter/material.dart';
import 'package:multi_store_app/screens/cart_screen.dart';
import 'package:multi_store_app/screens/customer_screens/customer_orders.dart';
import 'package:multi_store_app/screens/customer_screens/wishlist_screen.dart';
import 'package:multi_store_app/widgets/appbar_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Stack(children: [
        Container(
          height: 230,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.lightBlueAccent.shade100, Colors.blue]),
          ),
        ),
        CustomScrollView(slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            backgroundColor: Colors.white,
            floating: true,
            expandedHeight: 140,
            flexibleSpace: LayoutBuilder(builder: (context, constraints) {
              return FlexibleSpaceBar(
                title: AnimatedOpacity(
                  opacity: constraints.biggest.height <= 120 ? 1 : 0,
                  duration: const Duration(milliseconds: 300),
                  child: const Text(
                    "Account",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.lightBlueAccent.shade100, Colors.blue]),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30, top: 25),
                    child: Row(children: [
                      const CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            AssetImage("assets/images/inapp/guest.jpg"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          "Geust".toUpperCase(),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ]),
                  ),
                ),
              );
            }),
          ),
          SliverToBoxAdapter(
            child: Column(children: [
              Container(
                height: 80,
                width: MediaQuery.of(context).size.width * .8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade400,
                          border: Border.all(color: Colors.white, width: 3),
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(50),
                              topLeft: Radius.circular(50))),
                      child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CartScreen(
                                      back: AppBarBackButton()),
                                ));
                          },
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * .21,
                            child: const Center(
                              child: Text(
                                "Cart",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.lightBlueAccent,
                        border: Border.all(color: Colors.white, width: 3),
                      ),
                      child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const CustomerOrdersScreen(),
                                ));
                          },
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * .21,
                            child: const Center(
                              child: Text(
                                "Orders",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade400,
                          border: Border.all(color: Colors.white, width: 3),
                          borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(50),
                              topRight: Radius.circular(50))),
                      child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const WishlistScreen(),
                                ));
                          },
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * .21,
                            child: const Center(
                              child: Text(
                                "Wishlist",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.grey.shade300,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 150,
                      child: Image(
                          image: AssetImage("assets/images/inapp/logo.jpg")),
                    ),
                    const SizedBox(height: 10),
                    const ProfileHeaderLable(headerLabel: '  Account Info  '),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 260,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(children: const [
                          RepeatedListTaile(
                            title: "Email Address",
                            subTitle: "Example@gmail.com",
                            icon: Icons.email,
                          ),
                          BlueDivider(),
                          RepeatedListTaile(
                            title: "Phone Number",
                            subTitle: "Example: +213 123456789",
                            icon: Icons.phone,
                          ),
                          BlueDivider(),
                          RepeatedListTaile(
                            title: "Address",
                            subTitle: "Example: 140 - st - New Gersy",
                            icon: Icons.location_pin,
                          ),
                        ]),
                      ),
                    ),
                    const ProfileHeaderLable(
                        headerLabel: "  Account Settings  "),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 260,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(children: [
                          RepeatedListTaile(
                            title: 'Edit Profile',
                            icon: Icons.edit,
                            onListTap: () {},
                          ),
                          const BlueDivider(),
                          RepeatedListTaile(
                            title: 'Change Password',
                            icon: Icons.lock,
                            onListTap: () {},
                          ),
                          const BlueDivider(),
                          RepeatedListTaile(
                            title: 'LogOut',
                            icon: Icons.logout,
                            onListTap: () {
                              Navigator.pushReplacementNamed(context, "/");
                            },
                          ),
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          )
        ]),
      ]),
    );
  }
}

class BlueDivider extends StatelessWidget {
  const BlueDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Divider(
        color: Colors.lightBlueAccent,
        thickness: 1,
      ),
    );
  }
}

class RepeatedListTaile extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData icon;
  final Function? onListTap;
  const RepeatedListTaile({
    Key? key,
    required this.title,
    this.subTitle = "",
    required this.icon,
    this.onListTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          onListTap!();
        },
        child: ListTile(
          title: Text(title),
          subtitle: Text(subTitle),
          leading: Icon(icon),
        ));
  }
}

class ProfileHeaderLable extends StatelessWidget {
  final String headerLabel;
  const ProfileHeaderLable({Key? key, required this.headerLabel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 50,
            height: 40,
            child: Divider(
              thickness: 3,
              height: 2,
              color: Colors.grey,
            ),
          ),
          Text(
            headerLabel,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
              width: 50,
              height: 40,
              child: Divider(
                thickness: 3,
                height: 2,
                color: Colors.grey,
              )),
        ],
      ),
    );
  }
}
