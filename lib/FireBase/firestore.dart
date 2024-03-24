import 'package:cloud_firestore/cloud_firestore.dart';

class EmployeesService {
  //get collection of employee
  final CollectionReference employees =
      FirebaseFirestore.instance.collection('directory');
  // CREATE: add a new note
  Future<void> addEmployee(String employee) {
    return employees.add({
      'Employee': employee,
    });
  }

  // READ: get Employees from database
  Stream<QuerySnapshot> getEmployeesStream() {
    final employeesStream = employees.orderBy('Employee').snapshots();
    return employeesStream;
  }

  // UPDATE: update Employee given a doc id
  Future<void> updateEmployee(String docID, String newEmployee) {
    return employees.doc(docID).update({
      'Employee': newEmployee,
    });
  }

  // DELETE: delete Employee given a doc id
  Future<void> deleteEmployee(String docID) {
    return employees.doc(docID).delete();
  }
}

// FirestoreService for work with the accounting
class AccountingService {
  //get collection of accounting
  final CollectionReference accounting =
      FirebaseFirestore.instance.collection('accounting');
  // READ: get accounting from database
  Stream<QuerySnapshot> getAccountingStream() {
    final accountingStream = accounting.orderBy('Date').snapshots();

    return accountingStream;
  }

  // ADD to accounting
  Future<void> addOrder({
    required String employee,
    required String orderNumber,
    required DateTime date,
    required String model,
    required String company,
    required String price,
    String? cash,
    String? payDay,
  }) {
    //Проверяем, не пусты ли поля cash и payDay. Если пусты, присваиваем значение "0"
    final cashValue = cash?.isNotEmpty == true ? cash : "0";
    final payDayValue = payDay?.isNotEmpty == true ? payDay : "0";

    return accounting.add({
      'Employee': employee,
      'Order': orderNumber,
      'Date': Timestamp.fromDate(date), // Конвертируем DateTime в Timestamp
      'Model': model,
      'Company': company,
      'Price': price,
      'Cash': cashValue,
      'PayDay': payDayValue,
    });
  }

  // DELETE
  Future<void> deleteOrder(String docId) {
    return accounting.doc(docId).delete();
  }
}
