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
    apiKey: 'AIzaSyBnB_Doqt3jA50Ufu9j2g2OfLLPfCXalgA',
    appId: '1:525030120892:android:4a002818f691a638295fb9',
    messagingSenderId: '525030120892',
    projectId: 'flash-chat-f9b5a',
    storageBucket: 'flash-chat-f9b5a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyApDPWku3XFL6msW4YIhhJkCbATeNQskn8',
    appId: '1:525030120892:ios:92311367bcd7e46b295fb9',
    messagingSenderId: '525030120892',
    projectId: 'flash-chat-f9b5a',
    storageBucket: 'flash-chat-f9b5a.appspot.com',
    androidClientId: '525030120892-e6f8vjl9t71bv4h1npdk55ci68ap2dva.apps.googleusercontent.com',
    iosClientId: '525030120892-9ftqilhb91e6n2q7tinjajstdstogjap.apps.googleusercontent.com',
    iosBundleId: 'tech.srocks.firstchat',
  );
}
