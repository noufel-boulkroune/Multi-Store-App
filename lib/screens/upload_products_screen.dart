// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:multi_store_app/widgets/snackbar.dart';

class UploadProductsScreen extends StatelessWidget {
  const UploadProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final GlobalKey<ScaffoldMessengerState> _scafoldKey =
        GlobalKey<ScaffoldMessengerState>();

    late double price;
    late int quantity;
    late String productName;
    late String productDescription;

    void uploadProduct() {
      if (_formKey.currentState!.validate()) {
        print("valid");
        print(price);
        print(quantity);
        print(productName);
        print(productDescription);
      } else {
        SnackBarHundler.showSnackBar(_scafoldKey, "pleas fill all fields");
      }
    }

    return ScaffoldMessenger(
      key: _scafoldKey,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            reverse: true,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Form(
              key: _formKey,
              child: Column(children: [
                Row(
                  children: [
                    Container(
                      color: Colors.blueGrey.shade100,
                      width: size.width * 0.45,
                      height: size.width * 0.45,
                      child: const Center(
                        child: Text(
                          "You didn't \n pick images",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Divider(
                    color: Colors.lightBlueAccent,
                    thickness: 1.5,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Pleas enter product price";
                      } else if (value.isValidPrice() != true) {
                        return "invalid price";
                      } else {
                        return null;
                      }
                    },
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: textFormDecoration.copyWith(
                      labelText: "Price",
                      hintText: "Price ..\$",
                    ),
                    onSaved: (value) => price = double.parse(value!),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Pleas enter the quentity";
                      } else if (value.isValidQuentity() != true) {
                        return "invalid quentity";
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.number,
                    decoration: textFormDecoration.copyWith(
                      labelText: "Quetity",
                      hintText: "Add quantity",
                    ),
                    onSaved: (value) => quantity = int.parse(value!),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Pleas enter product name";
                        } else {
                          return null;
                        }
                      },
                      maxLength: 100,
                      maxLines: 3,
                      decoration: textFormDecoration.copyWith(
                        labelText: "Product name",
                        hintText: "Enter product name",
                      ),
                      onChanged: (value) => productName = value),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Pleas enter product description";
                        } else {
                          return null;
                        }
                      },
                      maxLength: 800,
                      maxLines: 5,
                      decoration: textFormDecoration.copyWith(
                        labelText: "product description",
                        hintText: "Enter product description",
                      ),
                      onChanged: (value) => productDescription = value),
                ),
              ]),
            ),
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.photo_library),
            ),
            const SizedBox(
              width: 10,
            ),
            FloatingActionButton(
              onPressed: () {
                uploadProduct();
              },
              child: const Icon(Icons.upload),
            )
          ],
        ),
      ),
    );
  }
}

var textFormDecoration = InputDecoration(
  labelText: "Price",
  hintText: "Price ..\$",
  //labelStyle: TextStyle(color: Colors.blue),
  border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
      borderSide: const BorderSide(color: Colors.lightBlueAccent)),
  enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
      borderSide: const BorderSide(color: Colors.lightBlueAccent, width: 1)),
  focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
      borderSide: const BorderSide(color: Colors.blue, width: 2)),
);

extension QuantityValidator on String {
  bool isValidQuentity() {
    return RegExp(r'^[1-9][0-9]*$').hasMatch(this);
  }
}

extension PriceValidator on String {
  bool isValidPrice() {
    return RegExp(r'^((([1-9][0-9]*[\.]*)||([0][\.]))([1-9]{1,2}))$')
        .hasMatch(this);
  }
}
