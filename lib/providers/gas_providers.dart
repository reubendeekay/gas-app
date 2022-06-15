import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:gas/models/product_model.dart';
import 'package:gas/models/provider_model.dart';

class GasProviders extends ChangeNotifier {
  List<ProviderModel> _providers = [];

  List<ProviderModel> get providers => _providers;

//REGISTER A NEW PROVIDER
  Future<void> registerProvider(
      ProviderModel provider, List<File> images, File logo) async {
    final id = FirebaseFirestore.instance.collection('providers').doc().id;

    List<String> imageUrls = [];

    for (File image in images) {
      final upload = await FirebaseStorage.instance
          .ref('providers/images/${DateTime.now().toIso8601String()}')
          .putFile(image);

      final downloadUrl = await upload.ref.getDownloadURL();

      imageUrls.add(downloadUrl);
    }

    final logoUpload =
        await FirebaseStorage.instance.ref('providers/$id').putFile(logo);

    final logoUrl = await logoUpload.ref.getDownloadURL();

    provider.id = id;
    provider.images = imageUrls;
    provider.logo = logoUrl;

    await FirebaseFirestore.instance
        .collection('providers')
        .doc(id)
        .set(provider.toJson());

    for (ProductModel product in provider.products!) {
      final productId = FirebaseFirestore.instance
          .collection('providers')
          .doc(id)
          .collection('products')
          .doc()
          .id;

      product.id = productId;

      await FirebaseFirestore.instance
          .collection('providers')
          .doc(id)
          .collection('products')
          .doc(productId)
          .set(product.toJson());
    }

    notifyListeners();
  }

  //GET ALL PROVIDER DETAILS FROM FIREBASE

  Future<void> getAllProviders() async {
    final providerResults =
        await FirebaseFirestore.instance.collection('providers').get();

    List<ProviderModel> allProviders = [];

    for (var doc in providerResults.docs) {
      await FirebaseFirestore.instance
          .collection('providers')
          .doc(doc.id)
          .collection('products')
          .get()
          .then((value) {
        ProviderModel singleProvider = ProviderModel.fromJson(doc);
        singleProvider.products =
            value.docs.map((e) => ProductModel.fromJson(e)).toList();

        allProviders.add(singleProvider);
      });
    }

    _providers = allProviders;
    notifyListeners();
  }
}
