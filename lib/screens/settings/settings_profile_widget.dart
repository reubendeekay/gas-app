import 'package:flutter/material.dart';
import 'package:gas/constants.dart';

class SettingsProfileWidget extends StatelessWidget {
  const SettingsProfileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
      child: Column(children: [
        Row(
          children: [
            const CircleAvatar(
              radius: 30,
            ),
            const SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'John Doe',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 2.5,
                ),
                Text(
                  'test@test.com',
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 9),
            decoration: BoxDecoration(
                color: kIconColor, borderRadius: BorderRadius.circular(3)),
            child: Row(children: [
              const Icon(
                Icons.info_outline,
                color: Colors.white,
                size: 20,
              ),
              const SizedBox(
                width: 15,
              ),
              const Text(
                'Regular user',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              const Text(
                'Upgrade',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ]))
      ]),
    );
  }
}
