import 'package:flutter/material.dart';
import 'package:gas/constants.dart';
import 'package:gas/helpers/distance_helper.dart';
import 'package:gas/models/provider_model.dart';
import 'package:gas/providers/location_provider.dart';
import 'package:gas/screens/provider_details/provider_details_screen.dart';
import 'package:get/route_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class ProviderInfo extends StatelessWidget {
  const ProviderInfo({Key? key, required this.onCancel, this.provider})
      : super(key: key);

  final Function onCancel;
  final ProviderModel? provider;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        Colors.white,
        Colors.white,
        Colors.white,
        Colors.white.withOpacity(0.8),
        Colors.white.withOpacity(0.5),
        Colors.white.withOpacity(0.05),
      ], end: Alignment.bottomCenter, begin: Alignment.topCenter)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(
          height: 15,
        ),
        Text(
          'Provider Info'.toUpperCase(),
          style:
              const TextStyle(fontWeight: FontWeight.w500, color: Colors.grey),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Text(
              provider == null ? '' : provider!.name!,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            GestureDetector(
                onTap: () {
                  onCancel();
                },
                child: const Icon(Icons.close))
          ],
        ),
        SizedBox(
          height: size.height * 0.07,
        ),
        if (provider != null)
          ProviderInfoCard(
            provider: provider!,
          ),
        const Spacer(),
        if (provider != null)
          Center(
              child: ProviderInfoEstimateIcon(
            provider: provider,
          )),
      ]),
    );
  }
}

class ProviderInfoCard extends StatelessWidget {
  const ProviderInfoCard({Key? key, required this.provider}) : super(key: key);
  final ProviderModel provider;

  @override
  Widget build(BuildContext context) {
    final locData =
        Provider.of<LocationProvider>(context, listen: false).locationData;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        'Overview'.toUpperCase(),
        style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.grey),
      ),
      const SizedBox(
        height: 5,
      ),
      Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(5))),
            padding: const EdgeInsets.all(20),
            child: Column(children: [
              Row(
                children: [
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Station'),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        height: 30,
                        child: Image.network(provider.logo!),
                      )
                    ],
                  )),
                  Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                        Text('Status'),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Open Now',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )
                      ])),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Ratings'),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.message_outlined,
                            color: kIconColor,
                            size: 20,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            (provider.ratings! / provider.ratingCount!)
                                .toStringAsFixed(1),
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 2.5,
                      ),
                      Text(
                        '${provider.ratingCount} Reviews',
                        style: const TextStyle(
                            color: Colors.blueGrey, fontSize: 12),
                      )
                    ],
                  )),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Location'),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.my_location_sharp,
                            color: kIconColor,
                            size: 20,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${calculateDistance(locData!.latitude!, locData.longitude!, provider.location!.latitude, provider.location!.longitude).toStringAsFixed(1)} KM',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 2.5,
                      ),
                      Text(
                        provider.address!,
                        style: const TextStyle(
                            color: Colors.blueGrey, fontSize: 12),
                      )
                    ],
                  ))
                ],
              )
            ]),
          ),
          Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                color: Colors.red,
                child: Text(
                  'KES ${(calculateDistance(locData.latitude!, locData.longitude!, provider.location!.latitude, provider.location!.longitude) * 20).toStringAsFixed(0)}',
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ))
        ],
      ),
      GestureDetector(
        onTap: () {
          Get.to(() => ProviderDetailsScreen(provider: provider));
        },
        child: Container(
          decoration: const BoxDecoration(
              color: kIconColor,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(5))),
          height: 50,
          child: const Center(
            child: Text(
              'View Profile',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      )
    ]);
  }
}

class ProviderInfoEstimateIcon extends StatelessWidget {
  const ProviderInfoEstimateIcon({Key? key, this.provider}) : super(key: key);
  final ProviderModel? provider;

  @override
  Widget build(BuildContext context) {
    final locData =
        Provider.of<LocationProvider>(context, listen: false).locationData;
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: kIconColor,
                width: 3,
              ),
              borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const Text(
                '     ESTIMATE      ',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              Text(
                calculateTime(
                    LatLng(locData!.latitude!, locData.longitude!),
                    LatLng(provider!.location!.latitude,
                        provider!.location!.longitude)),
                style: const TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        Container(
          height: 45,
          width: 3,
          color: kIconColor,
        ),
        const CircleAvatar(
          backgroundColor: kIconColor,
          child: Icon(
            Icons.motorcycle,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
