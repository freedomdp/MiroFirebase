import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:miro/FireBase/firebase_config.dart';
import 'package:miro/style/colors.dart';
import 'package:miro/screens/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseConfig.options,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Ship Cars',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        scaffoldBackgroundColor: AppColors.background,
      ),
      home: const HomePage(),
    );
  }
}
