import 'package:flutter/material.dart';
import 'package:miro/style/colors.dart';
import 'package:miro/style/text_styles.dart';
import 'package:miro/widgets/IconTextButton.dart';

class UniversalModal extends StatelessWidget {
  final Widget content;
  final String title;
  final String employeeName; // Добавляем параметр для имени сотрудника

  const UniversalModal({
    Key? key,
    required this.content,
    required this.title,
    this.employeeName = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.background,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Container(
        padding: EdgeInsets.all(20),
        constraints: BoxConstraints(minWidth: 300, maxWidth: 600),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, style: TextStyles.h1Style),
            SizedBox(height: 20),
            TextFormField(
              initialValue: employeeName,
              decoration: InputDecoration(labelText: 'Новое имя сотрудника'),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconTextButton(
                  icon: Icons.cancel,
                  text: 'Отмена',
                  onPressed: () => Navigator.of(context).pop(),
                  textStyle: TextStyles.textStyle.copyWith(color: AppColors.text), // Черный текст
                  backgroundColor: AppColors.contentBackground, // Серый фон
                ),
                SizedBox(width: 10),
                IconTextButton(
                  icon: Icons.save,
                  text: 'Сохранить',
                  onPressed: () {
                    // Реализация сохранения
                  },
                  textStyle: TextStyles.textStyle.copyWith(color: AppColors.background), // Белый текст
                  backgroundColor: AppColors.primary, // Темный фон
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
