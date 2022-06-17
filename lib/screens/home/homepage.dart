import 'package:flutter/material.dart';
import 'package:gas/constants.dart';
import 'package:gas/models/provider_model.dart';
import 'package:gas/providers/gas_providers.dart';
import 'package:gas/providers/location_provider.dart';
import 'package:gas/screens/home/home_app_bar.dart';
import 'package:gas/screens/home/homepage_provider_widget.dart';
import 'package:gas/screens/home/provider_info.dart';
import 'package:gas/screens/settings/settings_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:marker_icon/marker_icon.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  //Needed Variables
  GoogleMapController? _controller;
  ScrollController _scrollController = ScrollController();
  ProviderModel? selectedProvider;
  Set<Marker> _markers = <Marker>{};
  bool isInfo = false;

//Map Visual Configuration

  void _onMapCreated(GoogleMapController controller) async {
    _controller = controller;
    String value = await DefaultAssetBundle.of(context)
        .loadString('assets/map_style.json');
    _controller!.setMapStyle(value);

    final providers =
        Provider.of<GasProviders>(context, listen: false).providers;

    for (ProviderModel provider in providers) {
      _markers.add(
        Marker(
          markerId: MarkerId(provider.id!),
          onTap: () {
            setState(() {
              selectedProvider = provider;
            });

            _scrollController.animateTo(
              providers.indexOf(provider) *
                      MediaQuery.of(context).size.width *
                      .85 +
                  40,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          },
          //circle to show the mechanic profile in map
          icon: await MarkerIcon.downloadResizePicture(
            url: provider.logo!,

            imageSize: (140).toInt(),
            // borderSize: 10,
            // addBorder: true,
            // borderColor: kPrimaryColor
          ),
          position:
              LatLng(provider.location!.latitude, provider.location!.longitude),
        ),
      );
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<LocationProvider>(context, listen: false).getCurrentLocation();
    final locData =
        Provider.of<LocationProvider>(context, listen: false).locationData!;
    final providers =
        Provider.of<GasProviders>(context, listen: false).providers;

    return Scaffold(
      drawer: const SettingsScreen(),
      body: SafeArea(
        child: Stack(
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                markers: _markers,
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                zoomControlsEnabled: false,
                initialCameraPosition: CameraPosition(
                    target: LatLng(locData.latitude!, locData.longitude!),
                    zoom: 15),
              ),
            ),
            const HomeAppBar(),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: AnimatedOpacity(
                  opacity: isInfo ? 0 : 1,
                  duration: const Duration(milliseconds: 250),
                  child: SizedBox(
                    height: 140,
                    child: ListView(
                        controller: _scrollController
                          ..addListener(() {
                            if (_scrollController.offset >=
                                _scrollController.position.maxScrollExtent) {
                              int currentIndex = (_scrollController.offset ~/
                                      _scrollController.position.extentInside) +
                                  1;

                              _controller!.animateCamera(
                                  CameraUpdate.newCameraPosition(CameraPosition(
                                      target: LatLng(
                                          providers[currentIndex]
                                              .location!
                                              .latitude,
                                          providers[currentIndex]
                                              .location!
                                              .longitude),
                                      zoom: 15)));
                            } else {
                              int currentIndex = (_scrollController.offset ~/
                                  _scrollController.position.extentInside);

                              _controller!.animateCamera(
                                  CameraUpdate.newCameraPosition(CameraPosition(
                                      target: LatLng(
                                          providers[currentIndex]
                                              .location!
                                              .latitude,
                                          providers[currentIndex]
                                              .location!
                                              .longitude),
                                      zoom: 15)));
                            }
                          }),
                        scrollDirection: Axis.horizontal,
                        children: [
                          const SizedBox(
                            width: 15,
                          ),
                          ...List.generate(
                              providers.length,
                              (index) => GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedProvider = providers[index];
                                        isInfo = true;
                                      });
                                    },
                                    child: HomepageProviderWidget(
                                        provider: providers[index]),
                                  )),
                        ]),
                  ),
                )),
            AnimatedOpacity(
              opacity: isInfo ? 1 : 0,
              duration: const Duration(milliseconds: 250),
              child: IgnorePointer(
                ignoring: !isInfo,
                child: ProviderInfo(
                    onCancel: () {
                      setState(
                        () {
                          isInfo = false;
                          selectedProvider = null;
                        },
                      );
                    },
                    provider: selectedProvider),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
