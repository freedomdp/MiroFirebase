import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:miro/style/text_styles.dart'; // Убедитесь, что в этом файле определены TextStyles.tabHeader и TextStyles.tabText
import 'package:miro/widgets/sidebar.dart';
import 'package:miro/FireBase/firestore.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});
  // Firestore
  final AccountingService firestoreService = AccountingService();

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd.MM.yyyy');

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Smart Ship Cars'),
        leading: IconButton(
          icon: const Icon(Icons.person),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
      ),
      drawer: EmployeesSidebar(),
      body: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: StreamBuilder<QuerySnapshot>(
            stream: widget.firestoreService.getAccountingStream(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              List<DataRow> rows =
                  snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                String dateString = data['Date'] != null
                    ? formatter.format((data['Date'] as Timestamp).toDate())
                    : 'N/A';

                return DataRow(cells: [
                  DataCell(Text(data['Order'].toString(),
                      style: TextStyles.tabText)),
                  DataCell(Text(dateString, style: TextStyles.tabText)),
                  DataCell(Text(data['Employee'], style: TextStyles.tabText)),
                  DataCell(Text(data['Model'], style: TextStyles.tabText)),
                  DataCell(Text(data['Company'] ?? 'N/A',
                      style: TextStyles.tabText)),
                  DataCell(Text(data['Price'].toString(),
                      style: TextStyles.tabText)),
                  DataCell(
                      Text(data['Cash'].toString(), style: TextStyles.tabText)),
                  DataCell(Text(data['Pay Day'] ?? 'N/A',
                      style: TextStyles.tabText)),
                  DataCell(Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          // Реализуйте логику для редактирования записи
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          // Реализуйте логику для удаления записи
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
                        label: Text('Order', style: TextStyles.tabHeader)),
                    DataColumn(
                        label: Text('Date', style: TextStyles.tabHeader)),
                    DataColumn(
                        label: Text('Employee', style: TextStyles.tabHeader)),
                    DataColumn(
                        label: Text('Model', style: TextStyles.tabHeader)),
                    DataColumn(
                        label: Text('Company', style: TextStyles.tabHeader)),
                    DataColumn(
                        label: Text('Price', style: TextStyles.tabHeader)),
                    DataColumn(
                        label: Text('Cash', style: TextStyles.tabHeader)),
                    DataColumn(
                        label: Text('Pay Day', style: TextStyles.tabHeader)),
                    DataColumn(
                        label: Text('Actions',
                            style: TextStyles
                                .tabHeader)), // Добавлена колонка Actions
                  ],
                  rows: rows,
                ),
              );
            },
          ),
        ),
      ),
      // Добавление плавающей кнопки с иконкой и надписью
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Здесь должен быть код для добавления нового заказа
          // Например, открытие диалогового окна или новой страницы
        },
        icon: const Icon(Icons.add),
        label: const Text("Add new order"),
      ),
    );
  }
}
