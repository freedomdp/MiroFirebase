import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Для форматирования дат

class AccountingTable extends StatefulWidget {
  const AccountingTable({super.key});

  @override
  _AccountingTableState createState() => _AccountingTableState();
}

class _AccountingTableState extends State<AccountingTable> {
  final bool _sortAscending = true;
  final int _sortColumnIndex = 0;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('accounting').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) return Text('Ошибка: ${snapshot.error}');
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        List<DataRow> rows = [];

        try {
          rows = snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            DateTime date = (data['Date'] as Timestamp).toDate();
            String formattedDate = DateFormat('dd.MM.yyyy').format(date);

            return DataRow(cells: [
              DataCell(Text(data['Order'] ?? '')),
              DataCell(Text(formattedDate)),
              DataCell(Text(data['Employee'] ?? '')),
              DataCell(Text(data['Model'] ?? '')),
              DataCell(Text(data['Company'] ?? '')),
              DataCell(Text('${data['Price'] ?? ''}')),
              DataCell(Text('${data['Cash'] ?? ''}')),
              DataCell(Text('${data['Pay Day'] ?? ''}')),
              DataCell(Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () {
                      // Здесь будет код для редактирования записи
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      // Здесь будет код для удаления записи
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
            columns: const [
              DataColumn(label: Text('Order')),
              DataColumn(label: Text('Date')),
              DataColumn(label: Text('Employee')),
              DataColumn(label: Text('Model')),
              DataColumn(label: Text('Company')),
              DataColumn(label: Text('Price')),
              DataColumn(label: Text('Cash')),
              DataColumn(label: Text('Pay Day')),
              DataColumn(label: Text('Actions')), // Добавлена колонка Actions
            ],
            rows: rows,
          ),
        );
      },
    );
  }
}
