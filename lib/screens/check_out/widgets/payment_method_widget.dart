import 'package:flutter/material.dart';
import 'package:gas/constants.dart';

class PaymentMethodWidget extends StatelessWidget {
  const PaymentMethodWidget(
      {Key? key, this.isSelected = false, this.details, this.title, this.image})
      : super(key: key);

  final bool isSelected;
  final String? details;
  final String? image;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(vertical: 9),
      decoration: BoxDecoration(
        color: isSelected ? Colors.grey[200] : Colors.transparent,
        border: isSelected
            ? null
            : Border.all(
                color: Colors.grey[200]!,
                width: 1,
              ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(children: [
        SizedBox(
          width: 30,
          height: 30,
          child: Image.network(
            image!,
            fit: BoxFit.fitWidth,
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            title ?? 'Current Location',
          ),
          const SizedBox(
            height: 3,
          ),
          Text(
            details ?? 'Jogoo Road',
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
        ])),
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            border: !isSelected
                ? Border.all(
                    color: kIconColor,
                    width: 1,
                  )
                : null,
            color:
                isSelected ? kIconColor.withOpacity(0.2) : Colors.transparent,
            shape: BoxShape.circle,
          ),
          child: isSelected
              ? const Icon(
                  Icons.credit_card,
                  color: kIconColor,
                  size: 18,
                )
              : null,
        ),
      ]),
    );
  }
}
