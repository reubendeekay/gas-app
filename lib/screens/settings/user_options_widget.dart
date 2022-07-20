import 'package:flutter/material.dart';
import 'package:gas/providers/auth_provider.dart';
import 'package:gas/screens/chat/chatroom.dart';
import 'package:gas/screens/notifications/notifications_screen.dart';
import 'package:gas/screens/purchases/purchases_screen.dart';
import 'package:gas/screens/settings/frequent_providers.dart';

import 'package:gas/screens/user_profile/user_profile_screen.dart';
import 'package:get/route_manager.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class UserOptionsWidget extends StatelessWidget {
  const UserOptionsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context, listen: false).user;
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
            color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
        child: Column(children: [
          settingsOption(
              title: 'Account Settings',
              icon: Iconsax.profile_add,
              onTap: () {
                Get.to(() => const UserProfileScreen());
              }),
          settingsOption(
              title: 'Purchase History',
              icon: Iconsax.shopping_cart,
              onTap: () {
                Get.to(() => const PurchaseScreen());
              }),
          settingsOption(
              title: 'Frequent Providers',
              icon: Iconsax.like_1,
              onTap: () {
                Get.to(() => const FrequentProvidersScreen());
              }),
          settingsOption(
            title: 'Notifications',
            icon: Iconsax.notification,
            onTap: () {
              Get.to(() => NotificationsScreen());
            },
          ),
        ]));
  }

  Widget settingsOption({
    String? title,
    IconData? icon,
    Function? onTap,
  }) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) onTap();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
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
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
