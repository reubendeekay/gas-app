import 'package:flutter/material.dart';
import 'package:gas/providers/location_provider.dart';
import 'package:gas/screens/locations/recent_locations_screen.dart';
import 'package:gas/screens/settings/settings_screen.dart';
import 'package:gas/screens/search/search_overview_screen.dart';
import 'package:get/route_manager.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userLocation =
        Provider.of<LocationProvider>(context, listen: false).userLocation;
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40), color: Colors.white),
        child: Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            GestureDetector(
                onTap: () {
                  Get.to(() => const SettingsScreen());
                },
                child: const Icon(Iconsax.menu, color: Colors.black)),
            const Spacer(),
            GestureDetector(
              onTap: () {
                Get.to(() => const RecentLocationsScreen());
              },
              child: Row(
                children: [
                  const Text(
                    'Now',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  const Icon(
                    Icons.circle,
                    size: 5,
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  Text(
                    userLocation!.state!,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Icon(Icons.keyboard_arrow_down_outlined)
                ],
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                Get.to(() => const SearchOverviewScreen());
              },
              child: const Icon(
                Icons.search,
                size: 20,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
          ],
        ));
  }
}
