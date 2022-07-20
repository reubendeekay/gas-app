import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gas/constants.dart';
import 'package:gas/helpers/distance_helper.dart';
import 'package:gas/helpers/lists.dart';
import 'package:gas/models/product_model.dart';
import 'package:gas/models/provider_model.dart';
import 'package:gas/models/request_model.dart';
import 'package:gas/providers/auth_provider.dart';
import 'package:gas/providers/location_provider.dart';
import 'package:gas/screens/check_out/check_out_screen.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

class ProductSelectDialog extends StatefulWidget {
  const ProductSelectDialog(
      {Key? key, required this.product, required this.provider})
      : super(key: key);

  final ProductModel product;
  final ProviderModel provider;

  @override
  State<ProductSelectDialog> createState() => _ProductSelectDialogState();
}

class _ProductSelectDialogState extends State<ProductSelectDialog> {
  int litres = 0;
  bool isFinished = false;
  @override
  Widget build(BuildContext context) {
    final locData =
        Provider.of<LocationProvider>(context, listen: false).locationData!;
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
          child: Text(
            widget.product.name!,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
        const Divider(),
        Padding(
            padding: const EdgeInsets.all(15),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                children: [
                  Text(
                    widget.product.category!
                            .toString()
                            .toLowerCase()
                            .contains('gas')
                        ? 'Cylinder Type'
                        : 'Number of litres',
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      if (litres > 0) {
                        setState(() {
                          litres--;
                          widget.product.quantity = litres.toInt();
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Icon(
                        Icons.remove,
                        size: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Text(
                    widget.product.category!
                                .toString()
                                .toLowerCase()
                                .contains('gas') &&
                            litres > 0
                        ? gasQuantities[litres - 1]
                        : litres.toString(),
                    style: const TextStyle(fontSize: 18),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        litres++;
                        widget.product.quantity = litres.toInt();
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Icon(
                        Icons.add,
                        size: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Text(
                    'DeliveryFee',
                  ),
                  const Spacer(),
                  Text(
                    'KES ${(calculateDistance(locData.latitude!, locData.longitude!, widget.provider.location!.latitude, widget.provider.location!.longitude) * 20).toStringAsFixed(0)}',
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  const Text('Price'),
                  const Spacer(),
                  Text(
                    'KES ${(double.parse(widget.product.price!) * litres).toStringAsFixed(2)}',
                    style: const TextStyle(
                        color: kIconColor, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 45,
                width: double.infinity,
                child: RaisedButton(
                  onPressed: litres < 1
                      ? null
                      : () {
                          final user =
                              Provider.of<AuthProvider>(context, listen: false)
                                  .user;

                          final request = RequestModel(
                            products: [
                              widget.product,
                            ],
                            user: user,
                            userLocation:
                                GeoPoint(locData.latitude!, locData.longitude!),
                          );

                          request.deliveryFee = (calculateDistance(
                                      locData.latitude!,
                                      locData.longitude!,
                                      widget.provider.location!.latitude,
                                      widget.provider.location!.longitude) *
                                  20)
                              .floorToDouble();

                          request.total = request.products!
                                  .map((product) =>
                                      product.quantity *
                                      double.parse(product.price!))
                                  .reduce((a, b) => a + b) +
                              request.deliveryFee!;
                          Get.to(() => CheckoutScreen(
                                request: request,
                              ));
                        },
                  color: Colors.black,
                  textColor: Colors.white,
                  child: const Text('Checkout'),
                ),
              ),
            ])),
      ],
    ));
  }
}
