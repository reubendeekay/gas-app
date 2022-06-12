import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gas/models/product_model.dart';
import 'package:gas/models/user_model.dart';

class RequestModel {
  final String? id;
  final UserModel? driver;
  GeoPoint? driverLocation;
  GeoPoint? userLocation;
  final UserModel? user;
  final ProductModel? product;

  RequestModel(
      {this.driver,
      this.user,
      this.product,
      this.driverLocation,
      this.userLocation,
      this.id});
}
