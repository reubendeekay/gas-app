import 'package:flutter/material.dart';
import 'package:gas/constants.dart';
import 'package:gas/providers/location_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:provider/provider.dart';

class AddOnMap extends StatefulWidget {
  const AddOnMap({Key? key, this.onSelectLocation, this.onSelectUserLocation})
      : super(key: key);
  final Function(LatLng)? onSelectLocation;
  final Function(UserLocation)? onSelectUserLocation;
  @override
  _AddOnMapState createState() => _AddOnMapState();
}

class _AddOnMapState extends State<AddOnMap> {
  GoogleMapController? mapController;

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    String value = await DefaultAssetBundle.of(context)
        .loadString('assets/map_style.json');
    mapController!.setMapStyle(value);
  }

  @override
  Widget build(BuildContext context) {
    var locData = Provider.of<LocationProvider>(context);
    locData.getCurrentLocation();
    var _locationData = locData.locationData;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Location',
            style: TextStyle(
              color: Colors.white,
            )),
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: kIconColor,
      ),
      body: SafeArea(
        child: GoogleMap(
          onTap: (value) async {
            if (widget.onSelectLocation != null) {
              widget.onSelectLocation!(value);
            }

            if (widget.onSelectUserLocation != null) {
              final userLoc =
                  await Provider.of<LocationProvider>(context, listen: false)
                      .getLocationDetails(value);
              widget.onSelectUserLocation!(userLoc);
            }

            showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                      content: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Address',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            FutureBuilder<UserLocation>(
                                future: Provider.of<LocationProvider>(context,
                                        listen: false)
                                    .getLocationDetails(value),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                          ConnectionState.waiting ||
                                      !snapshot.hasData) {
                                    return const Center(
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    );
                                  }

                                  final userLoc = snapshot.data!;
                                  return Text(
                                    userLoc.address!,
                                  );
                                }),
                          ],
                        ),
                      ),
                      title: const Text('Confirm the location'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                          child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: const Text('Yes')),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              child: const Text('No')),
                        ),
                      ],
                    ));
          },
          onMapCreated: _onMapCreated,
          compassEnabled: true,
          myLocationEnabled: true,
          zoomGesturesEnabled: true,
          myLocationButtonEnabled: true,
          initialCameraPosition: CameraPosition(
              target:
                  LatLng(_locationData!.latitude!, _locationData.longitude!),
              zoom: 16),
        ),
      ),
    );
  }
}
