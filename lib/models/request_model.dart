import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gas/models/driver_model.dart';
import 'package:gas/models/product_model.dart';
import 'package:gas/models/user_model.dart';

class RequestModel {
  String? id;
  final DriverModel? driver;
  GeoPoint? driverLocation;
  GeoPoint? userLocation;
  final UserModel? user;
  String? paymentMethod;
  final String status;
  final Timestamp? createdAt;
  double? deliveryFee;
  final List<ProductModel>? products;
  double? total;

  RequestModel(
      {this.driver,
      this.user,
      this.products,
      this.driverLocation,
      this.userLocation,
      this.paymentMethod,
      this.id,
      this.total,
      this.createdAt,
      this.deliveryFee,
      this.status = 'pending'});

  Map<String, dynamic> toJson() {
    return {
      'driver': driver?.toJson(),
      'user': user?.toJson(),
      'products': products?.map((e) => e.toJson()).toList(),
      'driverLocation': driverLocation,
      'userLocation': userLocation,
      'paymentMethod': paymentMethod,
      'id': id,
      'total': total,
      'status': status,
      'createdAt': createdAt,
      'deliveryFee': deliveryFee,
    };
  }

  factory RequestModel.fromJson(dynamic json) {
    return RequestModel(
      driver:
          json['driver'] != null ? DriverModel.fromJson(json['driver']) : null,
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
      products: json['products'] != null
          ? json['products']
              .map<ProductModel>((e) => ProductModel.fromJson(e))
              .toList()
          : null,
      driverLocation: json['driverLocation'] as GeoPoint,
      userLocation: json['userLocation'] as GeoPoint,
      paymentMethod: json['paymentMethod'] as String,
      id: json['id'] as String,
      total: json['total'] as double,
      status: json['status'] as String,
      createdAt: json['createdAt'] as Timestamp,
      deliveryFee: double.parse(json['deliveryFee'].toString()),
    );
  }
}
