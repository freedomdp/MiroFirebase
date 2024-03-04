import 'package:flutter/material.dart';
import 'package:miro/style/text_styles.dart';
import 'package:miro/widgets/content_box.dart';
import 'package:miro/widgets/tables/DirectoryTable.dart';
import 'package:miro/widgets/tables/AccountingTable.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 1200;

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: isMobile ? screenWidth : 1200,
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                const Text('Smart Ship Cars', style: TextStyles.h1Style),
                const SizedBox(height: 30),
                ContentBox(
                  title: 'Учет заказов',
                  child: AccountingTable(), // Убран const
                ),
                const SizedBox(height: 30),
                ContentBox(
                  title: 'Сотрудники',
                  child: DirectoryTable(), // Убран const
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
