import 'package:flutter/material.dart';
import 'package:gas/constants.dart';

class ProductCategoryWidget extends StatelessWidget {
  const ProductCategoryWidget({Key? key, this.category, this.color})
      : super(key: key);
  final String? category;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: color ?? kIconColor),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              category ?? 'Gas',
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              height: 80,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                  child: Icon(
                Icons.water_drop_outlined,
                color: color ?? kIconColor,
                size: 30,
              )),
            ),
          ],
        ),
      ),
    );
  }
}
