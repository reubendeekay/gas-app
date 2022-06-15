import 'package:flutter/material.dart';
import 'package:gas/models/request_model.dart';
import 'package:gas/providers/location_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class TrailDeliveryDetailsWidget extends StatefulWidget {
  const TrailDeliveryDetailsWidget({Key? key, required this.request})
      : super(key: key);
  final RequestModel request;

  @override
  State<TrailDeliveryDetailsWidget> createState() =>
      _TrailDeliveryDetailsWidgetState();
}

class _TrailDeliveryDetailsWidgetState
    extends State<TrailDeliveryDetailsWidget> {
  String? userLocation;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<LocationProvider>(context, listen: false)
          .getLocationDetails(
        LatLng(widget.request.userLocation!.latitude,
            widget.request.userLocation!.longitude),
      )
          .then((value) {
        setState(() {
          userLocation = value.address;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Delivery Details',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Address',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              userLocation ?? 'Calculating...',
            ),
            const SizedBox(
              height: 3,
            ),
            const Divider(),
            const SizedBox(
              height: 5,
            ),
            const Text(
              'Transaction No',
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              widget.request.id!,
            ),
            const SizedBox(
              height: 5,
            ),
          ],
        ));
  }
}
