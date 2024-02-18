import 'package:flutter/material.dart';
import "style/text_styles.dart"; // Импортируем файл с определениями стилей текста
import "style/colors.dart"; // Импортируем файл с определениями цветов

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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Smart Ship Cars', style: H1.h1Style),
              SizedBox(height: 30), // Расстояние между заголовком и контейнерами
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 8, // 80% ширины
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.only(right: 30), // Отступ справа
                      decoration: BoxDecoration(
                        color: AppColors.contentBackground,
                        border: Border.all(color: AppColors.border),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text('Учет заказов', style: H2.h2Style),
                    ),
                  ),
                  Expanded(
                    flex: 2, // 20% ширины
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.contentBackground,
                        border: Border.all(color: AppColors.border),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text('Сотрудники', style: H2.h2Style),
                    ),
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
