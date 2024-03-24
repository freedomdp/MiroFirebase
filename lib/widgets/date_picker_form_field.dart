import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:miro/style/form_field_styles.dart';

class DatePickerFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;

  const DatePickerFormField({
    Key? key,
    required this.controller,
    required this.label,
    required this.hint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: FormFieldStyles.inputDecoration(label: label, hint: hint),
      readOnly: true, // Сделать поле только для чтения
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );
        if (picked != null) {
          controller.text = DateFormat('dd.MM.yyyy').format(picked);
        }
      },
    );
  }
}
