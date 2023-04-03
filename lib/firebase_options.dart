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
    apiKey: 'AIzaSyDRPz4oYZLOtYyLZImbeqKQUx9NcQCfNEA',
    appId: '1:684511302781:web:430cca64012cfb05db8d14',
    messagingSenderId: '684511302781',
    projectId: 'music-app-f0cfd',
    authDomain: 'music-app-f0cfd.firebaseapp.com',
    storageBucket: 'music-app-f0cfd.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCk2-30FxeNmEmMIUnDHUCenqdBN-bMtE0',
    appId: '1:684511302781:android:d39188a2128427c9db8d14',
    messagingSenderId: '684511302781',
    projectId: 'music-app-f0cfd',
    storageBucket: 'music-app-f0cfd.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBVJF70XwcXIx4Bq2cDteqsmZd2TauDLH8',
    appId: '1:684511302781:ios:7d8bc7f9b4c8d876db8d14',
    messagingSenderId: '684511302781',
    projectId: 'music-app-f0cfd',
    storageBucket: 'music-app-f0cfd.appspot.com',
    iosClientId: '684511302781-akkaljcmlaspf5q03caj25b17ljcob5f.apps.googleusercontent.com',
    iosBundleId: 'com.example.music',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBVJF70XwcXIx4Bq2cDteqsmZd2TauDLH8',
    appId: '1:684511302781:ios:7d8bc7f9b4c8d876db8d14',
    messagingSenderId: '684511302781',
    projectId: 'music-app-f0cfd',
    storageBucket: 'music-app-f0cfd.appspot.com',
    iosClientId: '684511302781-akkaljcmlaspf5q03caj25b17ljcob5f.apps.googleusercontent.com',
    iosBundleId: 'com.example.music',
  );
}