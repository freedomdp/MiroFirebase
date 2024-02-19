import 'package:flutter/material.dart';
import 'package:miro/style/colors.dart';
import 'package:miro/style/text_styles.dart';

class IconTextButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;
  final TextStyle? textStyle; // Стиль текста, который также определяет цвет иконки
  final Color? backgroundColor; // Фоновый цвет кнопки

  const IconTextButton({
    Key? key,
    required this.icon,
    required this.text,
    required this.onPressed,
    this.textStyle,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Определяем эффективный стиль текста
    final effectiveTextStyle = textStyle ?? TextStyles.textStyle;

    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(
        icon,
        // Цвет иконки совпадает с цветом текста
        color: effectiveTextStyle.color ?? AppColors.text,
      ),
      label: Text(
        text,
        style: effectiveTextStyle,
      ),
      style: ElevatedButton.styleFrom(
        primary: backgroundColor ?? AppColors.primary, // Фон кнопки
        onPrimary: effectiveTextStyle.color ?? AppColors.background, // Цвет текста и иконки
      ),
    );
  }
}
