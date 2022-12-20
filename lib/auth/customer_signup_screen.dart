import 'package:flutter/material.dart';

import '../widgets/auth_widgets.dart';

class CustomerSignupScreen extends StatefulWidget {
  static const routeName = "customer_signup";
  const CustomerSignupScreen({super.key});

  @override
  State<CustomerSignupScreen> createState() => _CustomerSignupScreenState();
}

class _CustomerSignupScreenState extends State<CustomerSignupScreen> {
  bool passwordVisibility = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        reverse: true,
        child: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height * .94,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const AuthHeaderLable(
                    headerLable: 'Sign Up',
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.lightBlueAccent,
                      child: Icon(
                        Icons.person,
                        size: 70,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.lightBlueAccent,
                              borderRadius: BorderRadius.circular(25)),
                          child: IconButton(
                              onPressed: () {
                                print("Pick image from camera");
                              },
                              icon: const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                              )),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Container(
                          // constraints: BoxConstraints.expand(),
                          decoration: BoxDecoration(
                              color: Colors.lightBlueAccent,
                              borderRadius: BorderRadius.circular(25)),
                          child: IconButton(
                              onPressed: () {
                                print("Pick image from Gallery");
                              },
                              icon: const Icon(
                                Icons.photo,
                                color: Colors.white,
                              )),
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                      validator: (value) =>
                          value!.isEmpty ? "Pleas enter your full name" : null,
                      decoration: textFormDecoration),
                  TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) =>
                          value!.isEmpty ? "Pleas enter your Email" : null,
                      decoration: textFormDecoration.copyWith(
                          labelText: "Email Adress",
                          hintText: "Enter your email")),
                  TextFormField(
                      obscureText: passwordVisibility,
                      validator: (value) =>
                          value!.isEmpty ? "Pleas enter your Password" : null,
                      decoration: textFormDecoration.copyWith(
                          labelText: "Password",
                          hintText: "Enter your password",
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  passwordVisibility = !passwordVisibility;
                                });
                              },
                              icon: passwordVisibility
                                  ? const Icon(
                                      Icons.visibility,
                                      color: Colors.lightBlueAccent,
                                    )
                                  : const Icon(
                                      Icons.visibility_off,
                                      color: Colors.lightBlueAccent,
                                    )))),
                  HaveAccount(
                    actionLabel: "Log In",
                    haveAccont: "Already have account? ",
                    onPressed: () {},
                  ),
                  AuthMainButton(
                    mainButtonLable: "Sign Up",
                    onPressed: () {
                      _formKey.currentState!.validate()
                          ? print("valid")
                          : print("Not valid");
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
