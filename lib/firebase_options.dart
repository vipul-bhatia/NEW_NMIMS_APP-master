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
    apiKey: 'AIzaSyDM-7KUEHnePtBRcy6kyKAtBAD4EO9LJv8',
    appId: '1:908976526954:web:b8236ecfb868f5975fdc13',
    messagingSenderId: '908976526954',
    projectId: 'nmimsapp-73574',
    authDomain: 'nmimsapp-73574.firebaseapp.com',
    storageBucket: 'nmimsapp-73574.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBsoo_66mi4NiXIgrlDoM2KTShi8DPPxj0',
    appId: '1:908976526954:android:fd403251d1c3bb535fdc13',
    messagingSenderId: '908976526954',
    projectId: 'nmimsapp-73574',
    storageBucket: 'nmimsapp-73574.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyASkQy2g_amT1gPiGgxDqdClS3iZ9JneWg',
    appId: '1:908976526954:ios:fbfef5f58e28062e5fdc13',
    messagingSenderId: '908976526954',
    projectId: 'nmimsapp-73574',
    storageBucket: 'nmimsapp-73574.appspot.com',
    iosClientId: '908976526954-bjfosfoksbhqv6ia4ic6us1ii0qalduo.apps.googleusercontent.com',
    iosBundleId: 'com.example.riveAnimation',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyASkQy2g_amT1gPiGgxDqdClS3iZ9JneWg',
    appId: '1:908976526954:ios:0ab67b0bf9fab13c5fdc13',
    messagingSenderId: '908976526954',
    projectId: 'nmimsapp-73574',
    storageBucket: 'nmimsapp-73574.appspot.com',
    iosClientId: '908976526954-2jvbbjba7dv1d6kae9bg9v7k190j6pc2.apps.googleusercontent.com',
    iosBundleId: 'com.example.riveAnimation.RunnerTests',
  );
}
