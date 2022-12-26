// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:multi_store_app/widgets/snackbar.dart';

class UploadProductsScreen extends StatefulWidget {
  const UploadProductsScreen({super.key});

  @override
  State<UploadProductsScreen> createState() => _UploadProductsScreenState();
}

class _UploadProductsScreenState extends State<UploadProductsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scafoldKey =
      GlobalKey<ScaffoldMessengerState>();

  late double price;
  late int quantity;
  late String productName;
  late String productDescription;

  List<XFile>? _imagesFileList;
  dynamic _pickedImageError;

  void _pickProductImages() async {
    try {
      await ImagePicker()
          .pickMultiImage(
        maxHeight: 300,
        maxWidth: 300,
        imageQuality: 95,
      )
          .then((value) {
        setState(() {
          _imagesFileList = value;
        });
      });
    } catch (error) {
      setState(() {
        _pickedImageError = error;
      });
      print(_pickedImageError);
    }
  }

  Widget previewImages() {
    if (_imagesFileList!.isNotEmpty) {
      return ListView.builder(
        itemBuilder: (context, index) {
          return Image.file(File(_imagesFileList![index].path));
        },
        itemCount: _imagesFileList == null ? 0 : _imagesFileList!.length,
      );
    } else {
      return Center(
        child: Text(
          "You didn't \n pick images",
          textAlign: TextAlign.center,
        ),
      );
    }
  }

  void uploadProduct() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (_imagesFileList!.isNotEmpty) {
        print("valid");
        print(price);
        print(quantity);
        print(productName);
        print(productDescription);

        setState(() {
          _imagesFileList = null;
        });
        _formKey.currentState!.reset();
      } else {
        SnackBarHundler.showSnackBar(_scafoldKey, "pleas pick images first");
      }
    } else {
      SnackBarHundler.showSnackBar(_scafoldKey, "pleas fill all fields");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                    Stack(
                      children: [
                        InkWell(
                          onTap: () {
                            _pickProductImages();
                          },
                          child: Container(
                              color: Colors.blueGrey.shade100,
                              width: size.width * 0.45,
                              height: size.width * 0.45,
                              child: _imagesFileList != null
                                  ? previewImages()
                                  : const Center(
                                      child: Text(
                                        "You didn't \n pick images",
                                        textAlign: TextAlign.center,
                                      ),
                                    )),
                        ),
                        _imagesFileList == [] || _imagesFileList == null
                            ? SizedBox()
                            : Positioned(
                                top: 0,
                                right: 0,
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _imagesFileList = null;
                                    });
                                  },
                                  icon: Icon(Icons.delete_forever),
                                ),
                              )
                      ],
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
              onPressed: _imagesFileList == [] || _imagesFileList == null
                  ? () {
                      _pickProductImages();
                    }
                  : () {
                      setState(() {
                        _imagesFileList = null;
                      });
                    },
              child: _imagesFileList == [] || _imagesFileList == null
                  ? Icon(Icons.photo_library)
                  : Icon(Icons.delete_forever),
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
