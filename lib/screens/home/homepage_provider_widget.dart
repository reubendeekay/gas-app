import 'package:flutter/material.dart';
import 'package:gas/constants.dart';
import 'package:gas/helpers/distance_helper.dart';
import 'package:gas/helpers/ratings_stars.dart';
import 'package:gas/models/provider_model.dart';
import 'package:gas/providers/location_provider.dart';
import 'package:gas/screens/provider_details/provider_details_screen.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

class HomepageProviderWidget extends StatelessWidget {
  const HomepageProviderWidget(
      {Key? key, required this.provider, this.isHome = true})
      : super(key: key);
  final bool isHome;

  final ProviderModel provider;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final locData =
        Provider.of<LocationProvider>(context, listen: false).locationData!;
    return Stack(
      children: [
        Container(
          width: isHome ? size.width * 0.85 : size.width,
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 80,
                width: 80,
                child: Image.network(
                  provider.images!.first,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    provider.name!,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 14,
                        color: kIconColor,
                      ),
                      Text(provider.address!,
                          style: const TextStyle(
                              fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: const [
                      Ratings(
                        rating: 4.5,
                        gesturesDisabled: true,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text('24', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(
                              () => ProviderDetailsScreen(provider: provider));
                        },
                        child: const Text(
                          'View Profile',
                          style: TextStyle(fontSize: 12, color: kIconColor),
                        ),
                      ),
                    ],
                  )
                ],
              )),
            ],
          ),
        ),
        Positioned(
            top: 16,
            right: 18,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
              color: Colors.red,
              child: Text(
                'KES ${(calculateDistance(locData.latitude!, locData.longitude!, provider.location!.latitude, provider.location!.longitude) * 20).toStringAsFixed(0)}',
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ))
      ],
    );
  }
}
