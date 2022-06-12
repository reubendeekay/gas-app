import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gas/constants.dart';
import 'package:gas/screens/settings/app_settings_widget.dart';
import 'package:gas/screens/settings/settings_profile_widget.dart';
import 'package:gas/screens/settings/user_options_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
          children: [
            const SettingsProfileWidget(),
            const SizedBox(
              height: 15,
            ),
            const UserOptionsWidget(),
            const SizedBox(
              height: 15,
            ),
            const AppSettingsWidget(),
            const SizedBox(
              height: 10,
            ),
            RaisedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                },
                color: kIconColor,
                textColor: Colors.white,
                child: const Text('Logout'))
          ],
        ),
      ),
    );
  }
}
