import 'package:flutter/material.dart';
import 'package:gas/models/request_model.dart';
import 'package:gas/screens/provider_details/product_widget.dart';
import 'package:intl/intl.dart';

class PurchasesWidget extends StatelessWidget {
  const PurchasesWidget({Key? key, required this.request}) : super(key: key);
  final RequestModel request;
  String formatDate() {
    if (DateTime.now().difference(request.createdAt!.toDate()).inDays == 0) {
      return DateFormat('HH:mm a').format(request.createdAt!.toDate());
    } else {
      return DateFormat('dd/MM/yyyy').format(request.createdAt!.toDate());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 5,
      ),
      child: Stack(
        children: [
          ProductWidget(
            product: request.products!.first,
          ),
          Positioned(
            bottom: 10,
            right: 8,
            child: Text(
              formatDate(),
            ),
          )
        ],
      ),
    );
  }
}
