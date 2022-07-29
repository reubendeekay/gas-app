import 'package:flutter/material.dart';
import 'package:gas/constants.dart';
import 'package:gas/models/product_model.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({Key? key, required this.product}) : super(key: key);
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name!,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        decoration: product.quantity < 1
                            ? TextDecoration.lineThrough
                            : null),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    'KES ${product.price!}',
                    style: TextStyle(
                        decoration: product.quantity < 1
                            ? TextDecoration.lineThrough
                            : null,
                        fontWeight: FontWeight.bold,
                        color: kIconColor),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    product.description!,
                    style: TextStyle(
                        decoration: product.quantity < 1
                            ? TextDecoration.lineThrough
                            : null,
                        fontSize: 12,
                        color: Colors.grey[400]),
                  ),
                ],
              ),
            ),
            const Divider()
          ],
        ),
        if (product.quantity < 1)
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              color: Colors.grey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Out of stock',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )
                ],
              ),
            ),
          ),
      ],
    );
  }
}
