import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class UserOptionsWidget extends StatelessWidget {
  const UserOptionsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
            color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
        child: Column(children: [
          settingsOption(),
          settingsOption(
              title: 'Purchase History', icon: Iconsax.shopping_cart),
          settingsOption(
            title: 'Favourites',
            icon: Iconsax.like_1,
          ),
          settingsOption(
            title: 'Notifications',
            icon: Iconsax.notification,
          ),
        ]));
  }

  Widget settingsOption({
    String? title,
    IconData? icon,
    Function? onTap,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(
            icon ?? Iconsax.message,
            size: 22,
          ),
          const SizedBox(
            width: 15,
          ),
          Text(
            title ?? 'Messages',
          ),
          Spacer(),
          const Icon(
            Icons.arrow_forward_ios,
            size: 16,
          ),
        ],
      ),
    );
  }
}
