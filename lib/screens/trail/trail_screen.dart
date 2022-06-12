import 'package:flutter/material.dart';
import 'package:gas/constants.dart';
import 'package:gas/models/request_model.dart';
import 'package:gas/screens/trail/widgets/delivery_stepper_indicator.dart';
import 'package:gas/screens/trail/widgets/driver_found_dialog.dart';
import 'package:gas/screens/trail/widgets/trail_delivery_sheet.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:marker_icon/marker_icon.dart';

class TrailScreen extends StatefulWidget {
  const TrailScreen({Key? key, required this.request}) : super(key: key);
  final RequestModel request;

  @override
  State<TrailScreen> createState() => _TrailScreenState();
}

class _TrailScreenState extends State<TrailScreen> {
  GoogleMapController? _controller;
  Set<Marker> _markers = <Marker>{};

  void _onMapCreated(GoogleMapController controller) async {
    _controller = controller;
    String value = await DefaultAssetBundle.of(context)
        .loadString('assets/map_style.json');
    _controller!.setMapStyle(value);

    _markers.add(
      Marker(
        markerId: const MarkerId('1'),
        onTap: () {},
        //circle to show the mechanic profile in map
        icon: await MarkerIcon.downloadResizePictureCircle(
            widget.request.user!.profilePic!,
            size: (100).toInt(),
            borderSize: 10,
            addBorder: true,
            borderColor: kPrimaryColor),
        position: LatLng(widget.request.userLocation!.latitude,
            widget.request.userLocation!.longitude),
      ),
    );

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2000), () {
      setState(() {
        isDriverFound = true;
        deliveryIndex = 2;
      });

      showDialog(
          context: context,
          builder: (ctx) => const Dialog(
                child: DriverFoundDialog(),
              ));
    });
  }

  bool isDriverFound = false;
  int deliveryIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
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
                          children: [
                            InkWell(
                              child: const Icon(
                                Icons.arrow_back_ios,
                                size: 18,
                              ),
                              onTap: () => Navigator.pop(context),
                            ),
                            const Spacer(),
                            const Text(
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
                        RichText(
                          text: const TextSpan(
                              text: 'Arriving at ',
                              style: TextStyle(color: Colors.grey),
                              children: [
                                TextSpan(
                                    text: '8:16',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600))
                              ]),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DeliveryStepperIndicator(
                          selectedIndex: deliveryIndex,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: const [
                            Text(
                              'Latest arrival by 8:50  ',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                            Icon(
                              Icons.info,
                              color: Colors.grey,
                              size: 14,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: GoogleMap(
                      onMapCreated: _onMapCreated,
                      markers: _markers,
                      zoomControlsEnabled: false,
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
                      initialCameraPosition: CameraPosition(
                          target: LatLng(widget.request.userLocation!.latitude,
                              widget.request.userLocation!.longitude),
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
              isDriverFound: isDriverFound,
            ),
          ],
        ),
      ),
    );
  }
}
