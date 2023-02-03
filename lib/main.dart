import 'package:catalogo_livro_aikido/app.dart';
import 'package:catalogo_livro_aikido/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } else {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBQoxwZmJAd7ZieJrGWiYGQ6anYYnTBK8Q",
          authDomain: "catalogo-de-livros-aikido.firebaseapp.com",
          projectId: "catalogo-de-livros-aikido",
          storageBucket: "catalogo-de-livros-aikido.appspot.com",
          messagingSenderId: "161739963411",
          appId: "1:161739963411:web:a6e57dc89b4f1bad2353e6",
          measurementId: "G-VG2D4ED2J8"),
    );
  }
  runApp(const MyApp());
}
