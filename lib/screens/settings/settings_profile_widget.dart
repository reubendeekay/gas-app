import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gas/constants.dart';
import 'package:gas/providers/auth_provider.dart';
import 'package:gas/screens/user_profile/user_profile_screen.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

class SettingsProfileWidget extends StatelessWidget {
  const SettingsProfileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context, listen: false).user;
    return GestureDetector(
      onTap: () {
        Get.to(() => const UserProfileScreen());
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
        child: Column(children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: CachedNetworkImageProvider(user!.profilePic!),
              ),
              const SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.fullName!,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 2.5,
                  ),
                  Text(
                    user.email!,
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
              child: Row(children: const [
                Icon(
                  Icons.info_outline,
                  color: Colors.white,
                  size: 20,
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  'Regular user',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
                Spacer(),
                Text(
                  'Upgrade',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ]))
        ]),
      ),
    );
  }
}
