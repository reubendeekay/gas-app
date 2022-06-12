import 'package:flutter/material.dart';
import 'package:gas/helpers/lists.dart';
import 'package:gas/screens/check_out/widgets/checkout_address.dart';
import 'package:gas/screens/check_out/widgets/payment_method_widget.dart';
import 'package:gas/screens/check_out/widgets/payment_widget.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int selectedAddress = 0;
  int selectedPaymentMethod = 0;
  @override
  Widget build(BuildContext context) {
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
                    2,
                    (index) => GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedAddress = index;
                        });
                      },
                      child: CheckoutAddress(
                        isSelected: selectedAddress == index,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    'Shipping To',
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
          Hero(tag: 'to-payment', child: PaymentWidget(total: 150)),
        ],
      ),
    );
  }
}
