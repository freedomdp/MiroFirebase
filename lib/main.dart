import 'package:flutter/material.dart';
import 'style/text_styles.dart';
import 'style/colors.dart';
import 'widgets/content_box.dart'; // Импортируем новый компонент

void main() {
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
    return Scaffold(
      body: Center(
        child: Container(
          width: 900,
          padding: EdgeInsets.zero,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Smart Ship Cars', style: H1.h1Style),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ContentBox(
                    title: 'Учет заказов',
                    child: Text('Здесь будет таблица заказов'), // Заглушка для таблицы
                    flex: 7,
                    margin: const EdgeInsets.only(right: 30),
                  ),
                  ContentBox(
                    title: 'Сотрудники',
                    child: Text('Здесь будет таблица сотрудников'), // Заглушка для таблицы
                    flex: 3,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
