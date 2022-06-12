import 'package:flutter/material.dart';
import 'package:gas/constants.dart';
import 'package:gas/helpers/ratings_stars.dart';

class DriverArrivedDialog extends StatelessWidget {
  const DriverArrivedDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 24,
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Delivery Driver ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Ratings(
                      rating: 4.5,
                      size: 14,
                      gesturesDisabled: true,
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text('KMFF 730P ',
                        style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                )),
                const SizedBox(
                  width: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      color: kIconColor, shape: BoxShape.circle),
                  child: const Icon(
                    Icons.call_outlined,
                    color: Colors.white,
                    size: 26,
                  ),
                )
              ],
            ),
            const Divider(),
            const Text(
                'Your delivery driver has arrived and is waiting for you. Please pick your delivery.'),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 48,
              width: double.infinity,
              child: RaisedButton(
                color: kIconColor,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'THANKS',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
