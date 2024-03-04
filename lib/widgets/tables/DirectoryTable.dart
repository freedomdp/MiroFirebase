import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:miro/bloc/directory_bloc.dart';
import 'package:miro/bloc/directory_event.dart';
import 'package:miro/widgets/universal_modal.dart';
import 'package:miro/style/text_styles.dart';

class DirectoryTable extends StatelessWidget {
  const DirectoryTable({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('directory').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Ошибка: ${snapshot.error}', style: TextStyles.textStyle);
        }

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final directoryBloc = BlocProvider.of<DirectoryBloc>(context);

        List<DataRow> rows =
            snapshot.data!.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;

          return DataRow(cells: [
            DataCell(Text(data['Employee'] ?? 'Нет данных',
                style: TextStyles.textStyle)),
            DataCell(Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        // Использование BlocProvider.value для передачи DirectoryBloc в UniversalModal
                        return BlocProvider.value(
                          value: directoryBloc,
                          child: UniversalModal(
                            title: 'Редактирование имени сотрудника',
                            employeeName:
                                data['Employee'], // Текущее имя сотрудника
                            documentId:
                                document.id, // ID документа для обновления
                            onSave: (String newName) {
                              // Обновление записи через DirectoryBloc
                              directoryBloc
                                  .add(EditDirectory(document.id, newName));
                            },
                            content: TextFormField(
                              initialValue: data['Employee'],
                              decoration: const InputDecoration(
                                labelText: 'Новое имя сотрудника',
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    // Удаление записи через DirectoryBloc
                    directoryBloc.add(DeleteDirectory(document.id));
                  },
                ),
              ],
            )),
          ]);
        }).toList();

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: const [
              DataColumn(
                  label: Text('Employee', style: TextStyles.tebleHeader)),
              DataColumn(label: Text('Actions', style: TextStyles.tebleHeader)),
            ],
            rows: rows,
          ),
        );
      },
    );
  }
}
