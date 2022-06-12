import 'package:flutter/material.dart';

class TrailDeliveryDetailsWidget extends StatelessWidget {
  const TrailDeliveryDetailsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Delivery Details',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Address',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Jogoo Road',
            ),
            SizedBox(
              height: 3,
            ),
            Divider(),
            SizedBox(
              height: 5,
            ),
            Text(
              'Source',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'Shell Jogoo Road',
            ),
            SizedBox(
              height: 5,
            ),
          ],
        ));
  }
}
