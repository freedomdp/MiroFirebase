import 'package:flutter/material.dart';
import 'colors.dart';

class TextStyles {
  static const TextStyle textStyle = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
    color: AppColors.text,
  );

  static const TextStyle tabHeader = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
    color: AppColors.text,
  );

  static const TextStyle tabText = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.normal,
    color: AppColors.text,
  );

  static const TextStyle h1Style = TextStyle(
    fontSize: 30.0,
    fontWeight: FontWeight.w800,
  );

  static const TextStyle h2Style = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle button_prymary = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
    color: AppColors.add,
  );
  static const TextStyle button_validate = TextStyle(
    fontSize: 19.0,
    fontWeight: FontWeight.w100,
    color: AppColors.text_secondary,
  );
  static const TextStyle button_cancel = TextStyle(
    fontSize: 19.0,
    fontWeight: FontWeight.w100,
    color: AppColors.text_secondary,
  );
}
