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
        return ios;
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
    apiKey: 'AIzaSyDRukoDhaIOkfXVuBcLG6ejyZZ9uOhAvV0',
    appId: '1:378071238336:web:926d23311ae21365f10f25',
    messagingSenderId: '378071238336',
    projectId: 'libraryautomation-3532b',
    authDomain: 'libraryautomation-3532b.firebaseapp.com',
    storageBucket: 'libraryautomation-3532b.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAsN6ux-qPnCcfplsGgts4WWcNIuy7cIKU',
    appId: '1:378071238336:android:034bd71360010a16f10f25',
    messagingSenderId: '378071238336',
    projectId: 'libraryautomation-3532b',
    storageBucket: 'libraryautomation-3532b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBb1OD6knZM95tz3bEx6Ww7B3GtHc8zcQ0',
    appId: '1:378071238336:ios:ff61f03476d78f79f10f25',
    messagingSenderId: '378071238336',
    projectId: 'libraryautomation-3532b',
    storageBucket: 'libraryautomation-3532b.appspot.com',
    iosBundleId: 'com.example.odevdeneme',
  );
}
