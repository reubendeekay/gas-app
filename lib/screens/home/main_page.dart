import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gas/models/user_model.dart';
import 'package:gas/screens/home/homepage.dart';
import 'package:gas/screens/trail/trail_screen.dart';
import 'package:gas/widgets/loading_screen.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Homepage();
          }

          final UserModel user = UserModel.fromJson(snapshot.data!);

          if (user.transitId != null) {
            return const TrailScreen();
          } else {
            return const Homepage();
          }
        });
  }
}
