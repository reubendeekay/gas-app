import 'package:flutter/material.dart';
import 'package:gas/models/request_model.dart';

class TrailOrderSummaryWidget extends StatelessWidget {
  const TrailOrderSummaryWidget({Key? key, required this.request})
      : super(key: key);
  final RequestModel request;

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
          ...List.generate(
              request.products!.length,
              (index) => orderItem(
                    index.toString(),
                    amount: request.products![index].quantity.toDouble(),
                    title: request.products![index].name!,
                    description: request.products![index].description!,
                  )),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Text(
                'KES ${request.total!.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 15),
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

  Widget orderItem(String index,
      {required String title,
      required String description,
      required double amount}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    description,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          const Divider(),
        ],
      ),
    );
  }
}
