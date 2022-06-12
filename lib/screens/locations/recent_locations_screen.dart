import 'package:flutter/material.dart';

class RecentLocationsScreen extends StatelessWidget {
  const RecentLocationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    children: const [
                      Text(
                        'Shell Gas Station',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        'Jogoo Road,Nairobi',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
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
        ...List.generate(4, (index) => locationWidget())
      ]),
    );
  }

  Widget locationWidget() {
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
                      children: const [
                        Text(
                          'Jogoo Lane',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'Jogoo Road,Nairobi',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
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
              SizedBox(
                height: 10,
              ),
              Divider(),
            ],
          ),
        )
      ]),
    );
  }
}
