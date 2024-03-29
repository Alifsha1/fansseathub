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
        return macos;
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
    apiKey: 'AIzaSyCf0oR-cHLEjvKlsWWorH1n_PtVIL-wk0M',
    appId: '1:744602426193:web:0801408f4d4e08f46bd170',
    messagingSenderId: '744602426193',
    projectId: 'fansseathub',
    authDomain: 'fansseathub.firebaseapp.com',
    storageBucket: 'fansseathub.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAxehn2_lmbnziMlj3aB82GOrpWRVb7bzg',
    appId: '1:744602426193:android:afa4d45faf3e3e186bd170',
    messagingSenderId: '744602426193',
    projectId: 'fansseathub',
    storageBucket: 'fansseathub.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB-9yw7BSZSstZaUDfR9ns2o7gucQEUJw4',
    appId: '1:744602426193:ios:dc736e62f72475466bd170',
    messagingSenderId: '744602426193',
    projectId: 'fansseathub',
    storageBucket: 'fansseathub.appspot.com',
    iosBundleId: 'com.example.fansseathub',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB-9yw7BSZSstZaUDfR9ns2o7gucQEUJw4',
    appId: '1:744602426193:ios:0c1f29ed78cf32026bd170',
    messagingSenderId: '744602426193',
    projectId: 'fansseathub',
    storageBucket: 'fansseathub.appspot.com',
    iosBundleId: 'com.example.fansseathub.RunnerTests',
  );
}
