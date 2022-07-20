import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gas/helpers/distance_helper.dart';
import 'package:gas/helpers/lists.dart';
import 'package:gas/models/request_model.dart';
import 'package:gas/providers/auth_provider.dart';
import 'package:gas/screens/trail/rating_screen.dart';
import 'package:gas/screens/trail/widgets/delivery_stepper_indicator.dart';
import 'package:gas/screens/trail/widgets/driver_arrived_dialog.dart';
import 'package:gas/screens/trail/widgets/driver_found_dialog.dart';
import 'package:gas/screens/trail/widgets/trail_delivery_sheet.dart';
import 'package:gas/widgets/loading_effect.dart';
import 'package:google_map_polyline_new/google_map_polyline_new.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:marker_icon/marker_icon.dart';
import 'package:provider/provider.dart';

class TrailScreen extends StatefulWidget {
  const TrailScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<TrailScreen> createState() => _TrailScreenState();
}

class _TrailScreenState extends State<TrailScreen> {
  GoogleMapController? _controller;
  Set<Marker> _markers = <Marker>{};
  Map<PolylineId, Polyline> _polylines = <PolylineId, Polyline>{};
//Polyline patterns
  List<List<PatternItem>> patterns = <List<PatternItem>>[
    <PatternItem>[], //line
    <PatternItem>[PatternItem.dash(30.0), PatternItem.gap(20.0)], //dash
    <PatternItem>[PatternItem.dot, PatternItem.gap(10.0)], //dot
    <PatternItem>[
      //dash-dot
      PatternItem.dash(30.0),
      PatternItem.gap(20.0),
      PatternItem.dot,
      PatternItem.gap(20.0)
    ],
  ];

  _addPolyline(List<LatLng> _coordinates) {
    PolylineId id = const PolylineId("1");
    Polyline polyline = Polyline(
        polylineId: id,
        patterns: patterns[0],
        color: Colors.blueAccent,
        points: _coordinates,
        width: 10,
        onTap: () {});

    setState(() {
      _polylines[id] = polyline;
    });
  }

//google cloud api key
  GoogleMapPolyline googleMapPolyline =
      GoogleMapPolyline(apiKey: "AIzaSyDIL1xyrMndlk2dSSSSikdobR8qDjz0jjQ");

  void _onMapCreated(GoogleMapController controller) async {
    _controller = controller;
    String value = await DefaultAssetBundle.of(context)
        .loadString('assets/map_style.json');
    _controller!.setMapStyle(value);
    final user = Provider.of<AuthProvider>(context, listen: false).user!;
    final requestData = await FirebaseFirestore.instance
        .collection('requests')
        .doc('users')
        .collection(user.userId!)
        .doc(user.transitId!)
        .get();

    final request = RequestModel.fromJson(requestData);

    _markers.addAll([
      Marker(
        markerId: const MarkerId('user'),
        onTap: () {},
        //circle to show the mechanic profile in map
        icon: await MarkerIcon.downloadResizePicture(
          url: request.user!.profilePic!,
          imageSize: (100).toInt(),
          // borderSize: 10,
          // addBorder: true,
          // borderColor: kPrimaryColor
        ),
        position: LatLng(
            request.userLocation!.latitude, request.userLocation!.longitude),
      ),
      if (request.driver != null)
        Marker(
          markerId: const MarkerId('driver'),
          onTap: () {},
          //circle to show the mechanic profile in map
          icon: await MarkerIcon.downloadResizePicture(
            url:
                'https://i.pinimg.com/originals/79/64/83/796483ae19e58f77dafca3e5d4f3e06e.png',
            imageSize: (110).toInt(),
            // borderSize: 10,
            // addBorder: true,
            // borderColor: kPrimaryColor
          ),
          position: LatLng(request.driverLocation!.latitude,
              request.driverLocation!.longitude),
        ),
    ]);
    var coordinates = await googleMapPolyline.getCoordinatesWithLocation(
        origin: LatLng(request.driverLocation!.latitude,
            request.driverLocation!.longitude),
        destination: LatLng(
            request.userLocation!.latitude, request.userLocation!.longitude),
        mode: RouteMode.driving);
    _addPolyline(coordinates!);

    setState(() {});
  }

  bool isDriverFound = false;
  final uid = FirebaseAuth.instance.currentUser!.uid;

  int deliveryIndex(String status) {
    if (status == 'Pending'.toLowerCase()) {
      return 0;
    } else if (status == 'Accepted'.toLowerCase()) {
      return 1;
    } else if (status == 'Driver Found'.toLowerCase()) {
      return 2;
    } else if (status == 'On Transit'.toLowerCase()) {
      return 3;
    } else if (status == 'Delivered'.toLowerCase() ||
        status == 'Completed'.toLowerCase()) {
      return 4;
    } else if (status == 'Arrived'.toLowerCase()) {
      return 4;
    } else {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('requests')
                .doc('users')
                .collection(uid)
                .where('status', isNotEqualTo: 'done')
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return LoadingEffect.getSearchLoadingScreen(context);
              }

              if (snapshot.data!.docs.isEmpty) {
                return LoadingEffect.getSearchLoadingScreen(context);
              }

              final data = RequestModel.fromJson(snapshot.data!.docs.first);
              return Stack(
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    child: Column(
                      children: [
                        Container(
                          color: Colors.white,
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: const [
                                  // InkWell(
                                  //   child: const Icon(
                                  //     Icons.arrow_back_ios,
                                  //     size: 18,
                                  //   ),
                                  //   onTap: () => Navigator.pop(context),
                                  // ),
                                  Spacer(),
                                  Text(
                                    'Help',
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              const Text(
                                'Heading your way...',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              if (deliveryIndex(data.status) <= 2)
                                const Text(
                                  'Waiting...',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              if (deliveryIndex(data.status) > 2)
                                RichText(
                                  text: TextSpan(
                                      text: 'Arriving at ',
                                      style:
                                          const TextStyle(color: Colors.grey),
                                      children: [
                                        TextSpan(
                                            text: calculateTime(
                                                calculateLatLng(
                                                  data.driverLocation!,
                                                ),
                                                calculateLatLng(
                                                  data.userLocation!,
                                                )),
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600))
                                      ]),
                                ),
                              const SizedBox(
                                height: 10,
                              ),
                              DeliveryStepperIndicator(
                                selectedIndex: deliveryIndex(data.status),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Text(
                                deliveryStatus[deliveryIndex(data.status)],
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: GoogleMap(
                            onMapCreated: _onMapCreated,
                            markers: _markers,
                            zoomControlsEnabled: false,
                            polylines: _polylines.values.toSet(),
                            myLocationEnabled: true,
                            myLocationButtonEnabled: true,
                            initialCameraPosition: CameraPosition(
                                target: LatLng(data.userLocation!.latitude,
                                    data.userLocation!.longitude),
                                zoom: 15),
                          ),
                        ),
                        const SizedBox(
                          height: 155,
                        ),
                      ],
                    ),
                  ),
                  TrailDeliverySheet(
                    request: data,
                  ),
                  if (deliveryIndex(data.status) == 2)
                    DriverFoundeDialog(
                      driver: data.driver!,
                      onClose: () async {
                        final uid = FirebaseAuth.instance.currentUser!.uid;
                        await FirebaseFirestore.instance
                            .collection('requests')
                            .doc('users')
                            .collection(uid)
                            .doc(data.id!)
                            .update({'status': 'on transit'});
                        setState(() {});
                      },
                    ),
                  if (data.status == 'Arrived'.toLowerCase())
                    DriverArrivedDialog(request: data),
                  if (data.status.toLowerCase() == 'delivered' ||
                      data.status.toLowerCase() == 'completed')
                    RatingScreen(request: data)
                ],
              );
            }),
      ),
    );
  }
}
