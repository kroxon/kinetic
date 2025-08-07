import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyBD5-JeKesr1iBsfTUxqsCSzSiobKqG9qU",
            authDomain: "kinetic-15184.firebaseapp.com",
            projectId: "kinetic-15184",
            storageBucket: "kinetic-15184.firebasestorage.app",
            messagingSenderId: "25373541594",
            appId: "1:25373541594:web:0461a36b5dc36291ee91e3"));
  } else {
    await Firebase.initializeApp();
  }
}
