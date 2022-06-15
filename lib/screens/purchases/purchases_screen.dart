import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gas/models/request_model.dart';
import 'package:gas/screens/purchases/widgets/purchase_widget.dart';
import 'package:gas/widgets/loading_effect.dart';

class PurchaseScreen extends StatelessWidget {
  const PurchaseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Purchases'),
        elevation: 0,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('requests')
              .doc('users')
              .collection(uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return LoadingEffect.getSearchLoadingScreen(context);
            }

            final List<DocumentSnapshot> docs = snapshot.data!.docs;
            return ListView(
              children: docs
                  .map(
                    (e) => PurchasesWidget(
                      request: RequestModel.fromJson(e),
                    ),
                  )
                  .toList(),
            );
          }),
    );
  }
}
