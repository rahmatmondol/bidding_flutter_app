// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA1rV5wnPirvZHQjyDowggdngru5jIUUyk',
    appId: '1:255497040130:android:98c5d0cbd3eec37374921b',
    messagingSenderId: '255497040130',
    projectId: 'bidding-ee056',
    databaseURL: 'https://bidding-ee056-default-rtdb.firebaseio.com',
    storageBucket: 'bidding-ee056.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAAJqDejx9PKrutYygBJ5cmvSFXAeF94Zk',
    appId: '1:255497040130:ios:32d85ea3a9bfe83274921b',
    messagingSenderId: '255497040130',
    projectId: 'bidding-ee056',
    databaseURL: 'https://bidding-ee056-default-rtdb.firebaseio.com',
    storageBucket: 'bidding-ee056.firebasestorage.app',
    iosClientId: '255497040130-tjuttb6p8mre59hv0fpd9s95g4mb3ord.apps.googleusercontent.com',
    iosBundleId: 'com.example.dirhamUae',
  );
}
