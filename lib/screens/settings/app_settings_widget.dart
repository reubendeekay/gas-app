import 'package:flutter/material.dart';
import 'package:gas/screens/settings/help_screen.dart';
import 'package:get/route_manager.dart';
import 'package:iconsax/iconsax.dart';

class AppSettingsWidget extends StatelessWidget {
  const AppSettingsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          settingsOption(
            title: 'Privacy & Security',
            icon: Iconsax.lock,
          ),
          settingsOption(
              title: 'Help & Feedback',
              icon: Iconsax.message_2,
              onTap: () {
                Get.to(() => const HelpScreen());
              }),
          settingsOption(
            title: 'About',
            icon: Iconsax.info_circle,
          ),
        ],
      ),
    );
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
