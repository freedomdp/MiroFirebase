import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'FireBase/firebase_config.dart';
import 'style/text_styles.dart';
import 'style/colors.dart';
import 'widgets/content_box.dart';
import 'widgets/tables/DirectoryTable.dart';
import 'widgets/tables/AccountingTable.dart';

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

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 900;

    return Scaffold(
      body: SingleChildScrollView( // Добавляем SingleChildScrollView
        child: Center(
          child: Container(
            width: isMobile ? screenWidth : 1200,
            padding: EdgeInsets.zero,
            child: isMobile
                ? Column(
              children: [
                Text('Smart Ship Cars', style: H1.h1Style),
                SizedBox(height: 30),
                ContentBox(
                  title: 'Учет заказов',
                  child: AccountingTable(),
                  margin: const EdgeInsets.only(bottom: 30),
                ),
                SizedBox(height: 30),
                ContentBox(
                  title: 'Сотрудники',
                  child: DirectoryTable(),
                  margin: const EdgeInsets.only(bottom: 30),
                ),
              ],
            )
                : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Smart Ship Cars', style: H1.h1Style),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 7,
                      child: ContentBox(
                        title: 'Учет заказов',
                        child: AccountingTable(),
                        margin: const EdgeInsets.only(bottom: 30),
                      ),
                    ),
                    SizedBox(width: 30),
                    Expanded(
                      flex: 3,
                      child: ContentBox(
                        title: 'Сотрудники',
                        child: DirectoryTable(),
                        margin: const EdgeInsets.only(bottom: 30),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
