import 'package:flutter/material.dart';
import 'package:gas/helpers/lists.dart';
import 'package:gas/models/request_model.dart';
import 'package:gas/providers/location_provider.dart';
import 'package:gas/screens/check_out/widgets/checkout_address.dart';
import 'package:gas/screens/check_out/widgets/payment_method_widget.dart';
import 'package:gas/screens/check_out/widgets/payment_widget.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key, required this.request}) : super(key: key);
  final RequestModel request;

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int selectedAddress = 0;
  int selectedPaymentMethod = 0;
  @override
  Widget build(BuildContext context) {
    final userlocations = Provider.of<LocationProvider>(
      context,
    ).preferredUserLocations();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Checkout',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  const Text(
                    'Shipping To',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ...List.generate(
                    userlocations.length,
                    (index) => GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedAddress = index;
                        });
                      },
                      child: CheckoutAddress(
                        isSelected: selectedAddress == index,
                        address: userlocations[index]['address'],
                        title: userlocations[index]['title'],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    'Payment Method',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ...List.generate(
                    paymentMethods.length,
                    (index) => GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedPaymentMethod = index;
                        });
                      },
                      child: PaymentMethodWidget(
                        isSelected: selectedPaymentMethod == index,
                        details: paymentMethods[index]['details'],
                        image: paymentMethods[index]['icon'],
                        title: paymentMethods[index]['name'],
                      ),
                    ),
                  ),
                ]),
          ),
          Hero(
              tag: 'to-payment',
              child: PaymentWidget(
                request: widget.request,
                paymentMethod: paymentMethods[selectedPaymentMethod]['name'],
              )),
        ],
      ),
    );
  }
}
