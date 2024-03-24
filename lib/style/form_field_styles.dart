// lib/style/form_field_styles.dart
import 'package:flutter/material.dart';
import 'colors.dart';
import 'text_styles.dart';

class FormFieldStyles {
  static InputDecoration inputDecoration({
    String? label,
    String? hint,
    FloatingLabelBehavior floatingLabelBehavior = FloatingLabelBehavior
        .always, // Добавляем параметр с дефолтным значением
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      labelStyle: TextStyles.textStyle.copyWith(color: AppColors.text),
      hintStyle: TextStyles.textStyle.copyWith(color: AppColors.text_secondary),
      floatingLabelBehavior: floatingLabelBehavior,
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.border, width: 1.0),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primary, width: 2.0),
      ),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.validation_failed, width: 2.0),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.validation_failed, width: 5.0),
      ),
    );
  }
}
