import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return android;
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDnU8U_Gv64o9Ik-AeXPY_mXZwIFgRe7mk',
    appId: '1:142037389077:android:7e7f243581c99f7ae7231c',
    messagingSenderId: '142037389077',
    projectId: 'pazzar-36917',
    storageBucket: 'pazzar-36917.appspot.com',
  );
}
