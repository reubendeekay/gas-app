import 'package:flutter/material.dart';
import 'package:gas/models/request_model.dart';
import 'package:gas/screens/provider_details/product_widget.dart';

class PurchasesWidget extends StatelessWidget {
  const PurchasesWidget({Key? key, required this.request}) : super(key: key);
  final RequestModel request;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 5,
      ),
      child: ProductWidget(
        product: request.products!.first,
      ),
    );
  }
}
