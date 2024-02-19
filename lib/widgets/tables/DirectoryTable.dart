import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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

        try {
          return ListView.separated(
            shrinkWrap: true, // Используйте внутри Column
            physics: NeverScrollableScrollPhysics(), // Отключает прокрутку списка
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var doc = snapshot.data!.docs[index].data() as Map<String, dynamic>;
              return ListTile(
                title: Text(doc['Employee'] ?? 'Нет данных'), // Исправлено на 'Employee'
                // Убран subtitle, так как используется только одно поле
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        // Реализуйте функционал редактирования
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        // Реализуйте функционал удаления
                      },
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => Divider(),
          );
        } catch (e) {
          return Text('Произошла ошибка: $e'); // Вывод ошибки, если что-то пошло не так
        }
      },
    );
  }
}
