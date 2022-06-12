import 'package:flutter/material.dart';
import 'package:gas/constants.dart';
import 'package:gas/helpers/color_loader.dart';

class DeliveryDriverProcessing extends StatelessWidget {
  const DeliveryDriverProcessing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 160,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            ColorLoader5(
              dotOneColor: kIconColor,
              dotTwoColor: kPrimaryColor,
              dotThreeColor: Colors.amber,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'WE ARE PROCESSING YOUR REQUEST',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'Your order will start soon',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
          ],
        ));
  }
}
