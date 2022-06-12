import 'package:flutter/material.dart';
import 'package:gas/screens/trail/widgets/delivery_driver_processing.dart';
import 'package:gas/screens/trail/widgets/trail_delivery_details_widget.dart';
import 'package:gas/screens/trail/widgets/trail_order_summary_widget.dart';

class TrailDeliverySheet extends StatelessWidget {
  const TrailDeliverySheet({Key? key, this.isDriverFound = false})
      : super(key: key);

  final bool isDriverFound;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: size.height - 225,
          ),
          !isDriverFound
              ? const DeliveryDriverProcessing()
              : Container(
                  width: size.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  // padding: const EdgeInsets.fromLTRB(15, 8, 15, 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                      Center(
                        child: Container(
                          height: 4,
                          width: 55,
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const DeliveryDriverWidget(),
                      const Divider(
                        thickness: 2,
                      ),
                      const TrailDeliveryDetailsWidget(),
                      const Divider(
                        thickness: 2,
                      ),
                      const TrailOrderSummaryWidget(),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}

class DeliveryDriverWidget extends StatelessWidget {
  const DeliveryDriverWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 26,
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Delivery Driver ',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 2.5,
                  ),
                  Text(
                    'KMFF730P ',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.grey[200]),
                child: const Icon(Icons.call),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: TextField(
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            fillColor: Colors.grey[200],
                            hintText: 'Send Message',
                            hintStyle: const TextStyle(
                                color: Colors.black, fontSize: 12),
                            filled: true,
                            border: InputBorder.none)),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
