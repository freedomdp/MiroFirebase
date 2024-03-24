import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:miro/style/colors.dart';
import 'package:miro/style/text_styles.dart';
import 'package:miro/style/form_field_styles.dart';
import 'package:miro/widgets/date_picker_form_field.dart';
import 'package:miro/widgets/employee_dropdown.dart';

class AddOrderDialog extends StatefulWidget {
  const AddOrderDialog({Key? key}) : super(key: key);

  @override
  _AddOrderDialogState createState() => _AddOrderDialogState();
}

class _AddOrderDialogState extends State<AddOrderDialog> {
  final _formKey = GlobalKey<FormState>();

  String? _selectedEmployee;
  final TextEditingController _orderNumberController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _cashController = TextEditingController();
  final TextEditingController _payDayController = TextEditingController();
// validation
  String? inputValidator(String? value,
      {int minLength = 0, bool required = true}) {
    if (required && (value == null || value.isEmpty)) {
      return 'This field cannot be empty';
    } else if (value != null && value.length < minLength) {
      return 'Must be at least $minLength characters';
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    _dateController.text = DateFormat('dd.MM.yyyy')
        .format(DateTime.now()); // Устанавливаем сегодняшнюю дату
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Order'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: EmployeeDropdown(
                  selectedEmployee: _selectedEmployee,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedEmployee = newValue;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: TextFormField(
                  controller: _orderNumberController,
                  decoration: FormFieldStyles.inputDecoration(
                      label: "Order number", hint: "Enter order number"),
                  validator: (value) =>
                      inputValidator(value, minLength: 3, required: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: DatePickerFormField(
                  controller: _dateController,
                  label: "Date",
                  hint: "dd.mm.yyyy",
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: TextFormField(
                  controller: _modelController,
                  decoration: FormFieldStyles.inputDecoration(
                      label: "Model", hint: "Enter model"),
                  validator: (value) =>
                      inputValidator(value, minLength: 3, required: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: TextFormField(
                  controller: _companyController,
                  decoration: FormFieldStyles.inputDecoration(
                      label: "Company", hint: "Enter company"),
                  validator: (value) =>
                      inputValidator(value, minLength: 3, required: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: TextFormField(
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  decoration: FormFieldStyles.inputDecoration(
                      label: "Price", hint: "\$0"),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter
                        .digitsOnly // Ограничивает ввод только цифрами
                  ],
                  validator: (value) =>
                      inputValidator(value, minLength: 2, required: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: TextFormField(
                  controller: _cashController,
                  keyboardType: TextInputType.number,
                  decoration: FormFieldStyles.inputDecoration(
                      label: "Cash", hint: "\$0"),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: TextFormField(
                  controller: _payDayController,
                  keyboardType: TextInputType.number,
                  decoration: FormFieldStyles.inputDecoration(
                      label: "Pay day", hint: "Enter pay day"),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          style: TextButton.styleFrom(
            minimumSize: const Size(100, 50), // Минимальный размер кнопки
          ),
          child: const Text('Cancel', style: TextStyles.button_cancel),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Form is valid!')),
              );
            }
          },
          style: TextButton.styleFrom(
            minimumSize: const Size(100, 50), // Минимальный размер кнопки
          ),
          child: const Text('Validate', style: TextStyles.button_validate),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              // Логика для добавления заказа в Firestore
              Navigator.of(context).pop();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Please fill out the form correctly')),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: AppColors.primary, // Цвет заливки кнопки
            minimumSize: const Size(
                100, 50), // Минимальный размер кнопки // Стиль текста кнопки
          ),
          child: const Text('Add', style: TextStyles.button_prymary),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _orderNumberController.dispose();
    _dateController.dispose();
    _modelController.dispose();
    _companyController.dispose();
    _priceController.dispose();
    _cashController.dispose();
    _payDayController.dispose();
    super.dispose();
  }
}
