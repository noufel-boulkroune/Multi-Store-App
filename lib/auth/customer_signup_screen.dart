import 'package:flutter/material.dart';

import '../widgets/auth_widgets.dart';
import '../widgets/snackbar.dart';

class CustomerSignupScreen extends StatefulWidget {
  static const routeName = "customer_signup";
  const CustomerSignupScreen({super.key});

  @override
  State<CustomerSignupScreen> createState() => _CustomerSignupScreenState();
}

final TextEditingController _nameControler = TextEditingController();
final TextEditingController _emailControler = TextEditingController();
final TextEditingController _passwordControler = TextEditingController();

class _CustomerSignupScreenState extends State<CustomerSignupScreen> {
  late String name, email, password;

  bool passwordVisibility = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scafoldKey =
      GlobalKey<ScaffoldMessengerState>();
  @override
  void dispose() {
    _nameControler.dispose();
    _emailControler.dispose();
    _passwordControler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scafoldKey,
      child: Scaffold(
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
                        controller: _nameControler,
                        validator: (value) => value!.isEmpty
                            ? "Pleas enter your full name"
                            : null,
                        decoration: textFormDecoration),
                    TextFormField(
                        controller: _emailControler,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Pleas enter your Email";
                          } else if (value.isValidEmail() == false) {
                            return "invalide email";
                          } else if (value.isValidEmail() == true) {
                            null;
                          }

                          return null;
                        },
                        decoration: textFormDecoration.copyWith(
                            labelText: "Email Adress",
                            hintText: "Enter your email")),
                    TextFormField(
                        controller: _passwordControler,
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
                        if (_formKey.currentState!.validate()) {
                          print("valid");
                          setState(() {
                            name = _nameControler.text;
                            email = _emailControler.text;
                            password = _passwordControler.text;
                          });
                        } else {
                          SnackBarHundler.showSnackBar(
                              _scafoldKey, "Pleas fill all fields");
                        }
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
