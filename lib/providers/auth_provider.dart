import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:gas/models/user_model.dart';

class AuthProvider with ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  Future<void> login(String email, String password) async {
    final userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userCredential.user!.uid)
        .get()
        .then((value) {
      _user = UserModel.fromJson(value);
    });
    await getCurrentUser();

    notifyListeners();
  }

  Future<void> signup(UserModel userModel) async {
    final userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: userModel.email!, password: userModel.password!);

    userModel.userId = userCredential.user!.uid;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userCredential.user!.uid)
        .set(userModel.toJson());

    await getCurrentUser();
    notifyListeners();
  }

  Future<void> getCurrentUser() async {
    final uid = await FirebaseAuth.instance.currentUser!.uid;

    _user = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((value) {
      return UserModel.fromJson(value);
    });

    notifyListeners();
  }
}
