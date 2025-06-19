import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyCnleVLg4l7uJhj5s6Ep1IDha-vM1ACrsY",
            authDomain: "festafacil-s8won.firebaseapp.com",
            projectId: "festafacil-s8won",
            storageBucket: "festafacil-s8won.firebasestorage.app",
            messagingSenderId: "937452478180",
            appId: "1:937452478180:web:a09f0d2915636bbfd1d6f1",
            measurementId: "G-R3BMJJVNZG"));
  } else {
    await Firebase.initializeApp();
  }
}
