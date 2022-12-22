import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

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
  XFile? _imageFile;
  dynamic _pickedImageError;

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

  void _pickImageFromCamera() async {
    try {
      final pickedImage = await ImagePicker().pickImage(
        source: ImageSource.camera,
        maxHeight: 300,
        maxWidth: 300,
        imageQuality: 95,
      );
      setState(() {
        _imageFile = pickedImage;
      });
    } catch (error) {
      setState(() {
        _pickedImageError = error;
      });
      print(_pickedImageError);
    }
  }

  void _pickImageFromGallery() async {
    try {
      final pickedImage = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxHeight: 300,
        maxWidth: 300,
        imageQuality: 95,
      );
      setState(() {
        _imageFile = pickedImage;
      });
    } catch (error) {
      setState(() {
        _pickedImageError = error;
      });
      print(_pickedImageError);
    }
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
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.lightBlueAccent,
                        backgroundImage: _imageFile == null
                            ? null
                            : FileImage(File(_imageFile!.path)),
                        child: _imageFile == null
                            ? Icon(
                                Icons.person,
                                size: 70,
                                color: Colors.white,
                              )
                            : null,
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
                                  _pickImageFromCamera();
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
                                  _pickImageFromGallery();
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
                          if (_imageFile != null) {
                            print("valid");
                            setState(() {
                              name = _nameControler.text;
                              email = _emailControler.text;
                              password = _passwordControler.text;
                              _formKey.currentState!.reset();
                              setState(() {
                                _imageFile = null;
                              });
                            });
                          } else {
                            SnackBarHundler.showSnackBar(
                                _scafoldKey, "Pleas pick image first");
                          }
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
