// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gas/constants.dart';
import 'package:gas/helpers/mpesa_helper.dart';
import 'package:gas/helpers/phone_number_helper.dart';
import 'package:gas/models/product_model.dart';
import 'package:gas/models/request_model.dart';
import 'package:gas/providers/auth_provider.dart';
import 'package:gas/providers/location_provider.dart';
import 'package:gas/providers/request_provider.dart';
import 'package:gas/screens/check_out/check_out_screen.dart';
import 'package:gas/screens/check_out/paypal_payment.dart';
import 'package:gas/screens/trail/trail_screen.dart';
import 'package:get/route_manager.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

class PaymentWidget extends StatefulWidget {
  const PaymentWidget(
      {Key? key, required this.request, required this.paymentMethod})
      : super(key: key);

  final RequestModel request;
  final String paymentMethod;

  @override
  State<PaymentWidget> createState() => _PaymentWidgetState();
}

class _PaymentWidgetState extends State<PaymentWidget> {
  bool isFinished = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.request.paymentMethod = widget.paymentMethod;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context, listen: false).user;
    final loc =
        Provider.of<LocationProvider>(context, listen: false).locationData;

    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Total',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            Text(
              'KES ${widget.request.total!.toStringAsFixed(2)}',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 48,
          child: SwipeableButtonView(
            buttonText: 'Slide to Pay',
            buttonWidget: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.grey,
            ),
            activeColor: kPrimaryColor,
            isFinished: isFinished,
            onWaitingProcess: () async {
              await Future.delayed(const Duration(milliseconds: 2), () async {
                if (widget.paymentMethod.toLowerCase() == 'm-pesa') {
                  await mpesaPayment(
                    phone: phoneNumberHelper(user!.phone!),
                    amount: widget.request.total!,
                  );
                } else if (widget.paymentMethod.toLowerCase() == 'paypal') {
                  Get.to(() => PaypalPayment(request: widget.request));
                }

                setState(() {
                  isFinished = true;
                });
              });
            },
            onFinish: () async {
              final request = RequestModel(
                  driverLocation: GeoPoint(loc!.latitude!, loc.longitude!),
                  products: widget.request.products,
                  user: widget.request.user,
                  userLocation: widget.request.userLocation,
                  paymentMethod: widget.request.paymentMethod,
                  deliveryFee: widget.request.deliveryFee,
                  total: widget.request.total,
                  createdAt: Timestamp.now(),
                  status: 'pending');
              await Provider.of<RequestProvider>(context, listen: false)
                  .sendPurchaseRequest(request);
              await Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade,
                      child: const TrailScreen()));
              setState(() {
                isFinished = false;
              });
            },
          ),
        ),

        // SizedBox(
        //   width: double.infinity,
        //   height: 45,
        //   child: RaisedButton(
        //     onPressed: () {},
        //     color: kPrimaryColor,
        //     textColor: Colors.white,
        //     child: const Text('PROCEED TO PAY'),
        //   ),
        // )
      ]),
    );
  }
}
