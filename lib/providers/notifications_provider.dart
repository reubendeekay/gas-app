import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:gas/models/notification_model.dart';
import 'package:gas/models/request_model.dart';

class NotificationsProvider {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final userNotificationsRef = FirebaseFirestore.instance
      .collection('userData')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('notifications');

  Future<void> sendPurchaseRequest(RequestModel request) async {
    final userNotification = NotificationsModel(
      id: request.id,
      message: 'You have ordered ${request.products!.first.name}',
      imageUrl:
          'https://uploads-ssl.webflow.com/60edc0a8835d5b38bf11f03f/61cf085303a8eef996acbdd7_Purchase-Order-Procedure.jpeg',
      type: 'purchase',
      senderId: uid,
      createdAt: request.createdAt,
    );

    final providerNotification = NotificationsModel(
      id: request.id,
      message:
          'You have received a new order request from${request.user!.fullName}.Please accept or reject the request',
      imageUrl:
          'https://uploads-ssl.webflow.com/60edc0a8835d5b38bf11f03f/61cf085303a8eef996acbdd7_Purchase-Order-Procedure.jpeg',
      type: 'purchase',
      senderId: uid,
      createdAt: request.createdAt,
    );

    await userNotificationsRef.doc().set(userNotification.toJson());

    await FirebaseFirestore.instance
        .collection('userData')
        .doc(request.products!.first.ownerId!)
        .collection('notifications')
        .doc()
        .set(providerNotification.toJson());
  }
}
