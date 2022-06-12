import 'package:flutter/material.dart';
import 'package:gas/constants.dart';
import 'package:gas/helpers/ratings_stars.dart';

class DriverFoundDialog extends StatefulWidget {
  const DriverFoundDialog({Key? key}) : super(key: key);

  @override
  State<DriverFoundDialog> createState() => _DriverFoundDialogState();
}

class _DriverFoundDialogState extends State<DriverFoundDialog> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).pop();
    });
  }

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
                'Your delivery driver has been found. Please wait for the driver to arrive'),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 48,
              width: double.infinity,
              child: RaisedButton(
                color: kPrimaryColor,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'OKAY',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
