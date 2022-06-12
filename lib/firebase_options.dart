// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDpRYaYw6x1VCEB7DQLZRksA15WkVd2eb4',
    appId: '1:902667118234:web:7b3fe99f558b22d94ae123',
    messagingSenderId: '902667118234',
    projectId: 'gas-app-e70fd',
    authDomain: 'gas-app-e70fd.firebaseapp.com',
    storageBucket: 'gas-app-e70fd.appspot.com',
    measurementId: 'G-RFM2G63F4C',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBuKPV0ziBVIn1NyHs7mhtXhrGZtJO0WB0',
    appId: '1:902667118234:android:ba079f36fd6369fa4ae123',
    messagingSenderId: '902667118234',
    projectId: 'gas-app-e70fd',
    storageBucket: 'gas-app-e70fd.appspot.com',
  );
}
