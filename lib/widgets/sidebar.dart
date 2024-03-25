import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:miro/FireBase/firestore.dart';
import 'package:miro/style/colors.dart';
import 'package:miro/style/text_styles.dart';

class EmployeesSidebar extends StatefulWidget {
  EmployeesSidebar({Key? key}) : super(key: key);

  // firestore
  final EmployeesService firestoreService = EmployeesService();

  @override
  State<EmployeesSidebar> createState() => _EmployeesSidebarState();
}

class _EmployeesSidebarState extends State<EmployeesSidebar> {
  // text controller
  final TextEditingController textController = TextEditingController();
  final double sidebarWidth = 400; // Установленная ширина sidebar

  // open a dialog vox to add a Employee
  void openEmployeesBox({
    String? docID,
    String label = "Employee Name",
    String buttonText = "Save",
    String initialValue = "",
  }) {
    textController.text =
        initialValue; // Установка начального значения для поля ввода

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: const TextStyle(
                    fontWeight: FontWeight.bold)), // Отображение лейбла
            TextField(
              controller: textController,
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              if (docID == null) {
                widget.firestoreService.addEmployee(textController.text);
              } else {
                widget.firestoreService
                    .updateEmployee(docID, textController.text);
              }
              textController.clear();
              Navigator.pop(context);
            },
            child: Text(buttonText), // Установка текста кнопки
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: sidebarWidth,
      child: Drawer(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.centerLeft,
              child: const Text(
                'Employees',
                style: TextStyles.h1Style,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Name', style: TextStyles.tabHeader),
                  Padding(
                    padding: EdgeInsets.only(right: 35),
                    child: Text('Actions', style: TextStyles.tabHeader),
                  ),
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: widget.firestoreService.getEmployeesStream(),
                  builder: (context, snapshot) {
                    // if we have data, get all the docs
                    if (snapshot.hasData) {
                      List notesList = snapshot.data!.docs;

                      // display as a list
                      return ListView.builder(
                        itemCount: notesList.length,
                        itemBuilder: (context, index) {
                          // get aech individual doc
                          DocumentSnapshot document = notesList[index];
                          String docID = document.id;

                          // get note from each doc
                          Map<String, dynamic> data =
                              document.data() as Map<String, dynamic>;
                          String noteText = data['Employee'];
                          // display as a list title
                          return ListTile(
                            title: Text(noteText, style: TextStyles.tabText),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // statsctic
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.insert_chart),
                                ),
                                // update button
                                IconButton(
                                  onPressed: () => openEmployeesBox(
                                    docID: document.id,
                                    label: "Edit employee name",
                                    buttonText: "Update",
                                    initialValue: data[
                                        'Employee'], // Используем значение из текущего документа
                                  ),
                                  icon: const Icon(Icons.edit),
                                ),
                                // delete button
                                IconButton(
                                  onPressed: () => widget.firestoreService
                                      .deleteEmployee(docID),
                                  icon: const Icon(Icons.delete),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return const Text(
                        "Employee list loading ...",
                        style: TextStyles.h2Style,
                      );
                    }
                  }),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
              child: ElevatedButton.icon(
                onPressed: () => openEmployeesBox(
                  label: "Enter new employee name",
                  buttonText: "Add",
                ),
                icon: const Icon(Icons.add,
                    color: AppColors.background), // Иконка кнопки
                label: const Text("Add employee",
                    style:
                        TextStyle(color: AppColors.background)), // Текст кнопки
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary, // Фон кнопки
                  foregroundColor:
                      AppColors.background, // Цвет текста и иконки при нажатии
                  shape: RoundedRectangleBorder(
                    // Скругление углов
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 8), // Внутренние отступы
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
