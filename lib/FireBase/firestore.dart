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

  // READ: get notes from database
  Stream<QuerySnapshot> getEmployeesStream() {
    final employeesStream = employees.orderBy('Employee').snapshots();

    return employeesStream;
  }

  // UPDATE: update notes given a doc id
  Future<void> updateEmployee(String docID, String newEmployee) {
    return employees.doc(docID).update({
      'Employee': newEmployee,
    });
  }

  // DELETE: delete notes given a doc id
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
}
