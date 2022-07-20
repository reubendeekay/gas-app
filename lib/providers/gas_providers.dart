import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:gas/models/product_model.dart';
import 'package:gas/models/provider_model.dart';
import 'package:gas/models/request_model.dart';

class GasProviders extends ChangeNotifier {
  List<ProviderModel> _providers = [];

  List<ProviderModel> get providers => _providers;

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

        final categories =
            singleProvider.products!.map((e) => e.category!).toList();
//Only have one occurence of each category
        singleProvider.categories = categories.toSet().toList();

        allProviders.add(singleProvider);
      });
    }

    _providers = allProviders;
    notifyListeners();
  }

  Future<List<ProviderModel>> searchProviders(String searchTerm) async {
    final allProviders =
        await FirebaseFirestore.instance.collection('providers').get();

    final convertedProviders =
        allProviders.docs.map((e) => ProviderModel.fromJson(e)).toList();

    List<ProviderModel> providerRes = [];
    for (ProviderModel p in convertedProviders) {
      final productts = await FirebaseFirestore.instance
          .collection('providers')
          .doc(p.id)
          .collection('products')
          .get();
      final productss =
          productts.docs.map((e) => ProductModel.fromJson(e)).toList();
      p.products = productss;

      providerRes.add(p);
    }

    final providersMatchingCriteria = providerRes
        .where((element) =>
            element.name!.toLowerCase().contains(searchTerm.toLowerCase()) ||
            element.address!.toLowerCase().contains(searchTerm.toLowerCase()) ||
            element.products!.any((element) =>
                element.name!.toLowerCase().contains(searchTerm.toLowerCase())))
        .toList();

    List<ProviderModel> finalProvs = [];

    for (ProviderModel p in providersMatchingCriteria) {
      final pCategories = p.products!.map((e) => e.category!).toList();
      p.categories = pCategories.toSet().toList();
      finalProvs.add(p);
    }

    return finalProvs;
  }

  Future<List<ProviderModel>> getFrequentProviders() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final requestsResults = await FirebaseFirestore.instance
        .collection('requests')
        .doc('users')
        .collection(uid)
        .orderBy('createdAt', descending: true)
        .get()
        .then((value) =>
            value.docs.map((e) => RequestModel.fromJson(e)).toList());
    final providerIdsFromRequests =
        requestsResults.map((e) => e.products!.first.ownerId!).toList();

    List<ProviderModel> providersFromRequests = [];

    for (String id in providerIdsFromRequests) {
      final provider = await FirebaseFirestore.instance
          .collection('providers')
          .doc(id)
          .get();
      final providerModel = ProviderModel.fromJson(provider);
      providersFromRequests.add(providerModel);
    }

    List<ProviderModel> providerRes = [];
    for (ProviderModel p in providersFromRequests) {
      final productts = await FirebaseFirestore.instance
          .collection('providers')
          .doc(p.id)
          .collection('products')
          .get();
      final productss =
          productts.docs.map((e) => ProductModel.fromJson(e)).toList();
      p.products = productss;

      providerRes.add(p);
    }

    List<ProviderModel> finalProvs = [];

    for (ProviderModel p in providerRes) {
      final pCategories = p.products!.map((e) => e.category!).toList();
      p.categories = pCategories.toSet().toList();
      finalProvs.add(p);
    }

    notifyListeners();

    return finalProvs.toSet().toList();
  }
}
