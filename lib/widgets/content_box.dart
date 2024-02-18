import 'package:flutter/material.dart';
import 'package:miro/style/colors.dart';
import 'package:miro/style/text_styles.dart';

class ContentBox extends StatelessWidget {
  final String title;
  final Widget child;
  final double flex;
  final EdgeInsets margin;

  const ContentBox({
    Key? key,
    required this.title,
    required this.child,
    this.flex = 1,
    this.margin = EdgeInsets.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex.toInt(),
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: margin,
        decoration: BoxDecoration(
          color: AppColors.contentBackground,
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Text(title, style: H2.h2Style),
            SizedBox(height: 20), // Отступ между заголовком и контентом
            child, // Содержимое контейнера, например, таблица
          ],
        ),
      ),
    );
  }
}
