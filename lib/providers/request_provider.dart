import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:gas/models/request_model.dart';
import 'package:gas/models/user_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RequestProvider with ChangeNotifier {
  Future<void> sendPurchaseRequest(RequestModel request) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final id = FirebaseFirestore.instance.collection('requests').doc().id;
    request.id = id;
//TO USER REQUEST POOL
    await FirebaseFirestore.instance
        .collection('requests')
        .doc('users')
        .collection(uid)
        .doc(id)
        .set(request.toJson());
//TO SPECIFIC PROVIDER REQUEST POOL
    await FirebaseFirestore.instance
        .collection('requests')
        .doc('providers')
        .collection(request.products!.first.ownerId!)
        .doc(id)
        .set(request.toJson());

//TO COMMON POOL FOR NEARBY DRIVERS
    await FirebaseFirestore.instance
        .collection('requests')
        .doc('common')
        .collection('drivers')
        .doc(id)
        .set(request.toJson());

    //SET REQUEST ID TO USER
    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      'transitId': id,
    });

    notifyListeners();
  }

  Future<void> sendDriverAcceptance(RequestModel request, UserModel driver,
      LatLng driverInitialLocation) async {
//TO USER REQUEST POOL
    await FirebaseFirestore.instance
        .collection('requests')
        .doc('users')
        .collection(request.user!.userId!)
        .doc(request.id!)
        .update({
      'driver': driver.toJson(),
      'driverLocation': GeoPoint(
          driverInitialLocation.latitude, driverInitialLocation.longitude),
      'status': 'driver found',
    });
//TO SPECIFIC PROVIDER REQUEST POOL
    await FirebaseFirestore.instance
        .collection('requests')
        .doc('providers')
        .collection(request.products!.first.ownerId!)
        .doc(request.id!)
        .update({
      'driver': driver.toJson(),
      'driverLocation': GeoPoint(
          driverInitialLocation.latitude, driverInitialLocation.longitude),
      'status': 'driver found',
    });
//TO COMMON POOL FOR NEARBY DRIVERS
    await FirebaseFirestore.instance
        .collection('requests')
        .doc('common')
        .collection('drivers')
        .doc(request.id!)
        .update({
      'driver': driver.toJson(),
      'driverLocation': GeoPoint(
          driverInitialLocation.latitude, driverInitialLocation.longitude),
      'status': 'driver found',
    });
  }
}
