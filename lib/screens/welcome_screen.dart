import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: depend_on_referenced_packages
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:multi_store_app/auth/customer_signup_screen.dart';
import 'package:multi_store_app/screens/customer_home_screen.dart';

import '../auth/customer_login_screen.dart';
import '../auth/supplier_login_screen.dart';
import '../auth/supplier_signup_screen.dart';
import '/widgets/blue_button.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _logoAnimationController;
  bool _processing = false;
  late String _userid;
  CollectionReference anonymous =
      FirebaseFirestore.instance.collection("anonymous");

  @override
  void initState() {
    _logoAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    _logoAnimationController.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _logoAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                "assets/images/inapp/bgimage.jpg",
              ),
              fit: BoxFit.cover),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AnimatedTextKit(
                isRepeatingAnimation: true,
                repeatForever: true,
                animatedTexts: [
                  ColorizeAnimatedText(
                    'Larry Page',
                    textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2),
                    colors: [Colors.white, Colors.lightBlueAccent],
                  ),
                  ColorizeAnimatedText(
                    'Duck Store',
                    textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2),
                    colors: [Colors.white, Colors.lightBlueAccent],
                  ),
                ],
              ),
              const SizedBox(
                height: 120,
                width: 200,
                child: Image(
                  image: AssetImage("assets/images/inapp/logo.jpg"),
                ),
              ),
              SizedBox(
                height: 80,
                child: DefaultTextStyle(
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      RotateAnimatedText('BUY'),
                      RotateAnimatedText('SHOP'),
                      RotateAnimatedText('DUCK STORE'),
                    ],
                    repeatForever: true,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 60,
                    width: MediaQuery.of(context).size.width * .5,
                    decoration: const BoxDecoration(
                      color: Color(0xFF434A59),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          bottomLeft: Radius.circular(50)),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Suppliers only",
                        style: TextStyle(
                            color: Colors.lightBlueAccent,
                            fontSize: 24,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width * .8,
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: Color(0xFF434A59),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              bottomLeft: Radius.circular(50)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AnimatedLogo(
                                logoAnimationController:
                                    _logoAnimationController),
                            BlueButton(
                              lable: "Log In",
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, SupplierLoginScreen.routeName);
                              },
                              width: .25,
                              color: Colors.lightBlueAccent,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: BlueButton(
                                lable: "Sign Up",
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, SupplierSignupScreen.routeName);
                                },
                                width: .25,
                                color: Colors.lightBlueAccent,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width * .8,
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: Color(0xFF434A59),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(50),
                          bottomRight: Radius.circular(50)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BlueButton(
                          lable: "Log In",
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, CustomerLoginScreen.routeName);
                          },
                          width: .25,
                          color: Colors.lightBlueAccent,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: BlueButton(
                            lable: "Sign Up",
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, CustomerSignupScreen.routeName);
                            },
                            width: .25,
                            color: Colors.lightBlueAccent,
                          ),
                        ),
                        AnimatedLogo(
                            logoAnimationController: _logoAnimationController),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                height: 90,
                decoration: const BoxDecoration(color: Color(0xFF434A59)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GoogleFacebookLogIn(
                      image: const Image(
                          image: AssetImage("assets/images/inapp/google.jpg")),
                      lable: 'Google',
                      onPressed: () {},
                    ),
                    GoogleFacebookLogIn(
                      image: const Image(
                          image:
                              AssetImage("assets/images/inapp/facebook.jpg")),
                      lable: 'Facebook',
                      onPressed: () {},
                    ),
                    _processing
                        ? const CircularProgressIndicator()
                        : GoogleFacebookLogIn(
                            image: const Icon(
                              Icons.person,
                              size: 50,
                              color: Colors.lightBlueAccent,
                            ),
                            lable: 'Guest',
                            onPressed: () async {
                              setState(() {
                                _processing = true;
                              });
                              await FirebaseAuth.instance
                                  .signInAnonymously()
                                  .whenComplete(() async {
                                _userid =
                                    FirebaseAuth.instance.currentUser!.uid;
                                await anonymous.doc(_userid).set({
                                  "name": "",
                                  "email": "",
                                  "profileImage": "",
                                  "phone": "",
                                  "address": "",
                                  "customerId": _userid
                                });
                              });
                              await Future.delayed(
                                      const Duration(microseconds: 10))
                                  .whenComplete(() =>
                                      Navigator.pushReplacementNamed(context,
                                          CustomerHomeScreen.routeName));
                            },
                          ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AnimatedLogo extends StatelessWidget {
  const AnimatedLogo({
    Key? key,
    required AnimationController logoAnimationController,
  })  : _logoAnimationController = logoAnimationController,
        super(key: key);

  final AnimationController _logoAnimationController;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _logoAnimationController.view,
      builder: (context, child) {
        return Transform.rotate(
          angle: _logoAnimationController.value * 2 * pi,
          child: child,
        );
      },
      child: const Image(image: AssetImage("assets/images/inapp/logo.jpg")),
    );
  }
}

class GoogleFacebookLogIn extends StatelessWidget {
  final String lable;
  final Function onPressed;
  final Widget image;
  const GoogleFacebookLogIn({
    Key? key,
    required this.lable,
    required this.onPressed,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: () {
          onPressed();
        },
        child: Column(
          children: [
            SizedBox(height: 50, width: 50, child: image),
            Text(
              lable,
              style: const TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
