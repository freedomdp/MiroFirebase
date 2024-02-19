import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/bloc/directory_bloc.dart';
import 'package:miro/style/colors.dart';
import 'package:miro/style/text_styles.dart';
import 'package:miro/widgets/IconTextButton.dart';

class UniversalModal extends StatelessWidget {
  final Widget content; // Добавляем параметр для содержимого модального окна
  final String title;
  final String employeeName;
  final String documentId;
  final Function(String newName) onSave;

  UniversalModal({
    Key? key,
    required this.title,
    required this.employeeName,
    required this.documentId,
    required this.onSave,
    required this.content, // Теперь 'content' является частью конструктора
  }) : super(key: key);

  final _formKey = GlobalKey<FormState>(); // Добавляем ключ для формы

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.background,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Container(
        padding: EdgeInsets.all(20),
        constraints: BoxConstraints(minWidth: 300, maxWidth: 600),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title, style: TextStyles.h1Style),
              SizedBox(height: 20),
              TextFormField(
                initialValue: employeeName,
                decoration: InputDecoration(labelText: 'Новое имя сотрудника'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите имя';
                  }
                  return null;
                },
                onSaved: (newValue) => onSave(newValue!),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconTextButton(
                    icon: Icons.cancel,
                    text: 'Отмена',
                    onPressed: () => Navigator.of(context).pop(),
                    textStyle: TextStyles.textStyle.copyWith(color: AppColors.text),
                    backgroundColor: AppColors.contentBackground,
                  ),
                  SizedBox(width: 10),
                  IconTextButton(
                    icon: Icons.save,
                    text: 'Сохранить',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save(); // Сохраняем форму
                        Navigator.of(context).pop(); // Закрываем модальное окно после сохранения
                      }
                    },
                    textStyle: TextStyles.textStyle.copyWith(color: AppColors.background),
                    backgroundColor: AppColors.primary,
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
