import 'package:flutter/material.dart';
import 'package:gas/constants.dart';
import 'package:gas/helpers/ratings_stars.dart';
import 'package:gas/models/request_model.dart';

class DriverArrivedDialog extends StatefulWidget {
  const DriverArrivedDialog({Key? key, required this.request})
      : super(key: key);
  final RequestModel request;

  @override
  State<DriverArrivedDialog> createState() => _DriverArrivedDialogState();
}

class _DriverArrivedDialogState extends State<DriverArrivedDialog> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      showDialog(
          context: context,
          builder: (ctx) => Dialog(
                child: DriverArrivedWidget(
                  request: widget.request,
                ),
              ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class DriverArrivedWidget extends StatelessWidget {
  const DriverArrivedWidget({Key? key, required this.request})
      : super(key: key);
  final RequestModel request;

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
                  backgroundImage: NetworkImage(
                    request.driver!.profilePic!,
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
                      request.driver!.fullName!,
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
