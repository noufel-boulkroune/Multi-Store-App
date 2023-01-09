import 'package:flutter/material.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:multi_store_app/widgets/snackbar.dart';

import '/widgets/blue_button.dart';
import '/widgets/appbar_widget.dart';

class AddAddress extends StatefulWidget {
  static const routeName = "add-address";
  const AddAddress({super.key});

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late String firstName, lastName, phoneNumber;
  String countryValue = "Choose Country";
  String stateValue = "Choose State";
  String cityValue = "Choose City";
  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: scaffoldKey,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const AppBarTitle(title: "Add Address"),
          leading: AppBarBackButton(color: Colors.black),
        ),
        body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: SafeArea(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 40, 0, 40),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: TextFormField(
                                decoration: textFormDecoration,
                                validator: (value) => value!.isEmpty
                                    ? "Pleas enter your first name"
                                    : null,
                                onSaved: (fName) {
                                  firstName = fName!;
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: TextFormField(
                                decoration: textFormDecoration.copyWith(
                                  labelText: "Last name",
                                  hintText: "Enter your last name",
                                ),
                                validator: (value) => value!.isEmpty
                                    ? "Pleas enter your lasst name"
                                    : null,
                                onSaved: (lName) {
                                  lastName = lName!;
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: TextFormField(
                                decoration: textFormDecoration.copyWith(
                                  labelText: "Phone number",
                                  hintText: "Enter your phone number",
                                ),
                                validator: (value) => value!.isEmpty
                                    ? "Pleas enter your phone number"
                                    : null,
                                onSaved: (phone) {
                                  phoneNumber = phone!;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SelectState(
                      onCountryChanged: (value) {
                        setState(() {
                          countryValue = value;
                        });
                      },
                      onStateChanged: (value) {
                        setState(() {
                          stateValue = value;
                        });
                      },
                      onCityChanged: (value) {
                        setState(() {
                          cityValue = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 120,
                    ),
                    Center(
                      child: BlueButton(
                          lable: "Add New Address",
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              if (countryValue != "Choose Country" &&
                                  stateValue != "Choose State" &&
                                  cityValue != "Choose City") {
                                formKey.currentState!.save();
                              } else {
                                SnackBarHundler.showSnackBar(
                                    scaffoldKey, "pleas set your locatuin");
                              }
                            } else {
                              SnackBarHundler.showSnackBar(
                                  scaffoldKey, "pleas fill all fields");
                            }
                          },
                          width: .8,
                          color: Colors.lightBlueAccent),
                    ),
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

var textFormDecoration = InputDecoration(
  labelText: "First name",
  hintText: "Enter your first name",
  hintMaxLines: 1,
  border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(25),
    borderSide: const BorderSide(color: Colors.lightBlueAccent, width: 1),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(25),
    borderSide: const BorderSide(color: Colors.blue, width: 2),
  ),
);
