import 'package:flutter/material.dart';
import 'package:gas/constants.dart';
import 'package:shimmer/shimmer.dart';

class DeliveryStepperIndicator extends StatelessWidget {
  const DeliveryStepperIndicator({Key? key, this.selectedIndex = 2})
      : super(key: key);
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
          5,
          (index) => Expanded(
              child:
                  rectangle(selectedIndex >= index, selectedIndex == index))),
    );
  }

  Widget rectangle(bool isSelected, bool isCurrent) {
    if (isCurrent) {
      return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: kIconColor,
        child: Container(
          height: 5,
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(1),
          ),
        ),
      );
    } else {
      return Container(
        height: 5,
        margin: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: !isSelected ? Colors.grey[300] : kIconColor,
          borderRadius: BorderRadius.circular(1),
        ),
      );
    }
  }
}
