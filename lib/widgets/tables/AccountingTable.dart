import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Для форматирования дат

class AccountingTable extends StatefulWidget {
  @override
  _AccountingTableState createState() => _AccountingTableState();
}

class _AccountingTableState extends State<AccountingTable> {
  bool _sortAscending = true;
  int _sortColumnIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Получаем доступ к цветам темы
    final colorScheme = Theme.of(context).colorScheme;

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('accounting').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) return Text('Ошибка: ${snapshot.error}');
        if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

        List<DataRow> rows = [];

        try {
          rows = snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            DateTime date = (data['Date'] as Timestamp).toDate();
            String formattedDate = DateFormat('dd.MM.yyyy').format(date);

            return DataRow(cells: [
              DataCell(Wrap(children: [Text(data['Order'] ?? '')])),
              DataCell(Wrap(children: [Text(formattedDate)])),
              DataCell(Wrap(children: [Text(data['Employee'] ?? '')])),
              DataCell(Wrap(children: [Text(data['Model'] ?? '')])),
              DataCell(Wrap(children: [Text(data['Company'] ?? '')])),
              DataCell(Wrap(children: [Text('${data['Price'] ?? ''}')])),
              DataCell(Wrap(children: [Text('${data['Cash'] ?? ''}')])),
              DataCell(Wrap(children: [Text('${data['Pay Day'] ?? ''}')])),
              DataCell(Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      // Реализуйте логику редактирования
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      // Реализуйте логику удаления
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
            sortColumnIndex: _sortColumnIndex,
            sortAscending: _sortAscending,
            headingRowColor: MaterialStateProperty.all(colorScheme.primary.withOpacity(0.2)), // Выделение заголовка цветом
            columns: [
              DataColumn(label: Text('Order')),
              DataColumn(label: Text('Date')),
              DataColumn(label: Text('Employee')),
              DataColumn(label: Text('Model')),
              DataColumn(label: Text('Company')),
              DataColumn(label: Text('Price')),
              DataColumn(label: Text('Cash')),
              DataColumn(label: Text('Pay Day')),
              DataColumn(label: Text('Actions')),
            ],
            rows: rows,
          ),
        );
      },
    );
  }
}
