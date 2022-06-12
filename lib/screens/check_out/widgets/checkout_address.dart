import 'package:flutter/material.dart';
import 'package:gas/constants.dart';

class CheckoutAddress extends StatelessWidget {
  const CheckoutAddress(
      {Key? key, this.isSelected = false, this.address, this.title})
      : super(key: key);

  final bool isSelected;
  final String? address;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
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
                  Icons.location_on_outlined,
                  color: kIconColor,
                  size: 18,
                )
              : null,
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
            address ?? 'Jogoo Road',
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
        ])),
        PopupMenuButton(
            padding: EdgeInsets.zero,
            icon: const Icon(
              Icons.more_vert,
              size: 20,
            ),
            itemBuilder: (context) {
              return const [
                PopupMenuItem(
                  child: Text('Edit'),
                ),
                PopupMenuItem(
                  child: Text('Delete'),
                ),
              ];
            }),
      ]),
    );
  }
}
