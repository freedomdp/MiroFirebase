import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:miro/style/colors.dart';
import 'package:miro/bloc/directory_bloc.dart';
import 'package:miro/bloc/directory_event.dart';


class DirectoryTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('directory').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Ошибка: ${snapshot.error}');
        }

        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        List<DataRow> rows = [];

        try {
          rows = snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;

            return DataRow(cells: [
              DataCell(Text(data['Employee'] ?? 'Нет данных')),
              DataCell(Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.blue),
                    onPressed: () {
                      // Реализуйте функционал редактирования
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      // Получаем доступ к BLoC
                      final bloc = BlocProvider.of<DirectoryBloc>(context);
                      // Отправляем событие удаления, передавая ID документа
                      bloc.add(DeleteDirectory(document.id)); // Убедитесь, что у вас есть доступ к document.id
                    },
                  ),
                ],
              )),
            ]);
          }).toList();
        } catch (e) {
          return Text('Произошла ошибка: $e');
        }

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: const [
              DataColumn(label: Text('Employee')),
              DataColumn(label: Text('Actions')),
            ],
            rows: rows,
          ),
        );
      },
    );
  }
}
