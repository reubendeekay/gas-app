import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gas/models/product_model.dart';

class ProviderModel {
  final String? id;
  final String? name;
  final String? address;
  final String? imageUrl;
  final String? logo;
  final double? ratings;
  final int? ratingCount;
  final GeoPoint? location;
  List<ProductModel>? products;

  ProviderModel(
      {this.name,
      this.address,
      this.imageUrl,
      this.logo,
      this.ratings,
      this.ratingCount,
      this.location,
      this.products,
      this.id});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'imageUrl': imageUrl,
      'logo': logo,
      'ratings': ratings,
      'ratingCount': ratingCount,
      'location': location,
      'products': products,
      'id': id
    };
  }

  factory ProviderModel.fromJson(dynamic json) {
    return ProviderModel(
      name: json['name'] as String,
      address: json['address'] as String,
      imageUrl: json['imageUrl'] as String,
      logo: json['logo'] as String,
      ratings: json['ratings'] as double,
      ratingCount: json['ratingCount'] as int,
      location: json['location'] as GeoPoint,
      id: json['id'] as String,
      products: (json['products'] as List<dynamic>)
          .map((e) => ProductModel.fromJson(e))
          .toList(),
    );
  }
}
