import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gas/constants.dart';
import 'package:gas/helpers/my_shimmer.dart';
import 'package:gas/models/product_model.dart';
import 'package:gas/screens/provider_details/product_widget.dart';

class AddProducts extends StatefulWidget {
  final Function(List<ProductModel> products)? onCompleted;
  const AddProducts({
    Key? key,
    this.onCompleted,
  }) : super(key: key);

  @override
  _AddProductsState createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  final _formKey = GlobalKey<FormState>();
  List<ProductModel> products = [];
  int productsLength = 1;
  String? name;
  String? price, category, description;
  final priceController = TextEditingController();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final categoryController = TextEditingController();

  final uid = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Product(s)',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        // automaticallyImplyLeading: false,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
              child: const Text(
                'Preview',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            ...List.generate(
              products.length,
              (index) => Container(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                child: Stack(
                  children: [
                    ProductWidget(
                      product: products[index],
                    ),
                    Positioned(
                        right: 10,
                        top: 5,
                        child: GestureDetector(
                            onTap: () {
                              products.removeAt(index);
                              setState(() {});
                            },
                            child: const Icon(Icons.close)))
                  ],
                ),
              ),
            ),
            if (products.isEmpty)
              MyShimmer(
                child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 25,
                          width: 200,
                          color: Colors.grey,
                          margin: const EdgeInsets.only(bottom: 5),
                        ),
                        Container(
                          height: 10,
                          color: Colors.grey,
                          width: 100,
                          margin: const EdgeInsets.only(bottom: 5),
                        ),
                        Container(
                          height: 15,
                          color: Colors.grey,
                        ),
                      ],
                    )),
              ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
              child: const Text(
                'Fill in all the details',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: size.width,
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: Colors.grey[200]),
                        child: TextFormField(
                            controller: nameController,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Please enter the name of the product';
                              }

                              return null;
                            },
                            decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                labelText: 'Name of product',
                                labelStyle: const TextStyle(fontSize: 14),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2),
                                    borderSide: const BorderSide(
                                        color: kPrimaryColor, width: 1)),
                                border: InputBorder.none),
                            onChanged: (text) => {
                                  setState(() {
                                    name = text;
                                  })
                                }),
                      ),
                      Container(
                        width: size.width,
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: Colors.grey[200]),
                        child: TextFormField(
                            controller: categoryController,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Please enter category of the product';
                              }

                              return null;
                            },
                            decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                labelText: 'Category',
                                labelStyle: const TextStyle(fontSize: 14),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2),
                                    borderSide: const BorderSide(
                                        color: kPrimaryColor, width: 1)),
                                border: InputBorder.none),
                            onChanged: (text) => {
                                  setState(() {
                                    category = text;
                                  })
                                }),
                      ),
                      Container(
                        width: size.width,
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: Colors.grey[200]),
                        child: TextFormField(
                            controller: descriptionController,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Please enter the description of the product';
                              }

                              return null;
                            },
                            decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                labelText: 'Product Description',
                                labelStyle: const TextStyle(fontSize: 14),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2),
                                    borderSide: const BorderSide(
                                        color: kPrimaryColor, width: 1)),
                                border: InputBorder.none),
                            onChanged: (text) => {
                                  setState(() {
                                    description = text;
                                  })
                                }),
                      ),
                      Container(
                        width: size.width,
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: Colors.grey[200]),
                        child: TextFormField(
                            controller: priceController,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Please enter the price of the product';
                              }

                              return null;
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                labelText: 'Price',
                                labelStyle: const TextStyle(fontSize: 14),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2),
                                    borderSide: const BorderSide(
                                        color: kPrimaryColor, width: 1)),
                                border: InputBorder.none),
                            onEditingComplete: () {
                              products.add(ProductModel(
                                name: name,
                                price: price,
                              ));
                            },
                            onChanged: (text) => {
                                  setState(() {
                                    price = text;
                                  })
                                }),
                      ),
                      const Divider(
                        color: Colors.black,
                      )
                    ])),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              height: 45,
              child: RaisedButton(
                onPressed: () {
                  setState(() {
                    products.add(ProductModel(
                        price: price,
                        name: name,
                        category: category,
                        description: description,
                        ownerId: uid));
                    price = null;
                    name = null;
                    category = null;
                    description = null;
                    priceController.clear();
                    nameController.clear();
                    categoryController.clear();
                    descriptionController.clear();
                  });
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                color: kPrimaryColor,
                child: const Text(
                  'Add',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              height: 45,
              child: RaisedButton(
                onPressed: products.isEmpty
                    ? null
                    : () {
                        widget.onCompleted!(products);
                        Navigator.pop(context);
                      },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                color: kPrimaryColor,
                child: const Text(
                  'Complete',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
