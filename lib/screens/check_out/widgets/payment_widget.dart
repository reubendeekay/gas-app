import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gas/constants.dart';
import 'package:gas/models/product_model.dart';
import 'package:gas/models/request_model.dart';
import 'package:gas/providers/auth_provider.dart';
import 'package:gas/providers/location_provider.dart';
import 'package:gas/screens/check_out/check_out_screen.dart';
import 'package:gas/screens/trail/trail_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

class PaymentWidget extends StatefulWidget {
  const PaymentWidget({Key? key, required this.total}) : super(key: key);

  final double total;

  @override
  State<PaymentWidget> createState() => _PaymentWidgetState();
}

class _PaymentWidgetState extends State<PaymentWidget> {
  bool isFinished = false;

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
              'KES ${widget.total.toStringAsFixed(2)}',
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
            onWaitingProcess: () {
              Future.delayed(const Duration(milliseconds: 500), () {
                setState(() {
                  isFinished = true;
                });
              });
            },
            onFinish: () async {
              final request = RequestModel(
                driver: user,
                driverLocation: GeoPoint(loc!.latitude!, loc.longitude!),
                id: '1',
                product: ProductModel(),
                user: user,
                userLocation: GeoPoint(loc.latitude!, loc.longitude!),
              );

              await Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade,
                      child: TrailScreen(
                        request: request,
                      )));

              //TODO: For reverse ripple effect animation
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
