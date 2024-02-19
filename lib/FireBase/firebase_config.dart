// lib/FireBase/firebase_config.dart
import 'package:firebase_core/firebase_core.dart';

class FirebaseConfig {
  static FirebaseOptions get options => const FirebaseOptions(
    apiKey: "AIzaSyCJ7dnM0ICGC54cz8Z7t1ivN9lP224CL_s", // Ваши данные
    authDomain: "miro-5e729.firebaseapp.com",
    projectId: "miro-5e729",
    storageBucket: "miro-5e729.appspot.com",
    messagingSenderId: "951248361387",
    appId: "1:951248361387:web:09a74d078d8802ad3064ee",
    // Добавьте другие параметры конфигурации по необходимости
  );
}
