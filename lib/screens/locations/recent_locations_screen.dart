import 'package:flutter/material.dart';
import 'package:gas/providers/auth_provider.dart';
import 'package:gas/providers/location_provider.dart';
import 'package:provider/provider.dart';

class RecentLocationsScreen extends StatelessWidget {
  const RecentLocationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context, listen: false).user!;
    final userLoc =
        Provider.of<LocationProvider>(context, listen: false).userLocation!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location History'),
        backgroundColor: Colors.grey[50],
        elevation: 0.5,
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Find what you need near you',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                  'We use your address to help you find the best spots nearby'),
              const SizedBox(
                height: 20,
              ),
              TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter a new address',
                  hintStyle: const TextStyle(fontSize: 14),
                  fillColor: Colors.grey[300],
                  filled: true,
                  prefixIcon: const Icon(
                    Icons.search,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Nearby',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(children: [
                const Icon(Icons.send),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userLoc.state!,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        userLoc.address!,
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 12),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.grey[200], shape: BoxShape.circle),
                  child: const Icon(
                    Icons.edit,
                    size: 20,
                  ),
                )
              ]),
            ],
          ),
        ),
        const Divider(),
        const SizedBox(
          height: 5,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: const Text(
            'Recent Locations',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        ...List.generate(
            user.locations!.length,
            (index) => locationWidget(
                  user.locations![index].state!,
                  user.locations![index].address!,
                ))
      ]),
    );
  }

  Widget locationWidget(String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
      child: Row(children: [
        const Icon(Icons.location_on),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          subtitle,
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 12),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.grey[200], shape: BoxShape.circle),
                    child: const Icon(
                      Icons.edit,
                      size: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(),
            ],
          ),
        )
      ]),
    );
  }
}
