import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:miro/FireBase/firestore.dart';
import 'package:miro/style/colors.dart';
import 'package:miro/style/text_styles.dart';

class EmployeesSidebar extends StatefulWidget {
  EmployeesSidebar({Key? key}) : super(key: key);

  // firestore
  final FirestoreService firestoreService = FirestoreService();

  @override
  State<EmployeesSidebar> createState() => _EmployeesSidebarState();
}

class _EmployeesSidebarState extends State<EmployeesSidebar> {
  // text controller
  final TextEditingController textController = TextEditingController();

  // open a dialog vox to add a note
  void openEmployeesBox({String? docID}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
          content: TextField(
            controller: textController,
          ),
          actions: [
            // button to save
            ElevatedButton(
                onPressed: () {
                  // add a new note
                  if (docID == null) {
                    widget.firestoreService.addEmployee(textController.text);
                  }
                  // update an existing note
                  else {
                    widget.firestoreService
                        .updateEmployee(docID, textController.text);
                  }

                  // clear the text controller
                  textController.clear();

                  // close the box
                  Navigator.pop(context);
                },
                child: const Text('Add'))
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                          title: Text(noteText, style: TextStyles.tebleText),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // update button
                              IconButton(
                                onPressed: () => openEmployeesBox(docID: docID),
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
                    return const Text("No notes ...");
                  }
                }),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
            child: Align(
              alignment: Alignment.center,
              child: Ink(
                decoration: BoxDecoration(
                  color: AppColors.primary, // Цвет фона кнопки
                  borderRadius:
                      BorderRadius.circular(100), // Делаем круглую форму
                ),
                child: IconButton(
                  icon: const Icon(Icons.add),
                  color: AppColors.background, // Цвет иконки
                  onPressed: () => openEmployeesBox(), // Действие при нажатии
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
