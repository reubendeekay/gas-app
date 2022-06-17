import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:gas/constants.dart';
import 'package:gas/helpers/ratings_stars.dart';
import 'package:gas/models/user_model.dart';

class DriverFoundeDialog extends StatefulWidget {
  const DriverFoundeDialog({Key? key, required this.driver}) : super(key: key);
  final UserModel driver;

  @override
  State<DriverFoundeDialog> createState() => _DriverFoundeDialogState();
}

class _DriverFoundeDialogState extends State<DriverFoundeDialog> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      showDialog(
          context: context,
          builder: (ctx) => Dialog(
                child: DriverFound(
                  driver: widget.driver,
                ),
              ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class DriverFound extends StatefulWidget {
  const DriverFound({Key? key, required this.driver}) : super(key: key);
  final UserModel driver;

  @override
  State<DriverFound> createState() => _DriverFoundState();
}

class _DriverFoundState extends State<DriverFound> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 10), () {
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
                CircleAvatar(
                  radius: 24,
                  backgroundImage: CachedNetworkImageProvider(
                    widget.driver.profilePic!,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.driver.fullName!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Ratings(
                      rating: 4.5,
                      size: 14,
                      gesturesDisabled: true,
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    const Text('KMFF 730P ',
                        style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                )),
                const SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: () async {
                    await FlutterPhoneDirectCaller.callNumber(
                        widget.driver.phone!);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                        color: kIconColor, shape: BoxShape.circle),
                    child: const Icon(
                      Icons.call_outlined,
                      color: Colors.white,
                      size: 26,
                    ),
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
