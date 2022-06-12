import 'package:flutter/material.dart';

class TrailOrderSummaryWidget extends StatelessWidget {
  const TrailOrderSummaryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Order Summary',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Ordered at 10:00 AM',
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
          const SizedBox(
            height: 15,
          ),
          ...List.generate(1, (index) => orderItem(index.toString())),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Total',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Text(
                'KES 180',
                style: TextStyle(fontSize: 15),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget orderItem(String index) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                color: Colors.grey[400],
                padding: const EdgeInsets.all(5),
                child: Text(
                  index,
                  style: const TextStyle(fontSize: 13),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Column(
                children: const [
                  Text(
                    'Super Diesel',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Spicy',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Divider(),
        ],
      ),
    );
  }
}
