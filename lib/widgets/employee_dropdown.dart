import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:miro/fireBase/firestore.dart';
import 'package:miro/style/form_field_styles.dart';

class EmployeeDropdown extends StatefulWidget {
  final String? selectedEmployee;
  final ValueChanged<String?> onChanged;

  const EmployeeDropdown({
    Key? key,
    this.selectedEmployee,
    required this.onChanged,
  }) : super(key: key);

  @override
  _EmployeeDropdownState createState() => _EmployeeDropdownState();
}

class _EmployeeDropdownState extends State<EmployeeDropdown> {
  final EmployeesService _employeesService = EmployeesService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _employeesService.getEmployeesStream(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }
        var employees = snapshot.data!.docs
            .map((doc) => doc['Employee'] as String)
            .toList();
        return DropdownButtonFormField<String>(
          value: widget.selectedEmployee,
          onChanged: widget.onChanged,
          decoration: FormFieldStyles.inputDecoration(label: "Employee", hint: "Select an employee"),
          items: employees.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        );
      },
    );
  }
}
