import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  //get collection of notes
  final CollectionReference employes =
      FirebaseFirestore.instance.collection('directory');
  // CREATE: add a new note
  Future<void> addNote(String employee) {
    return employes.add({
      'Employee': employee,
    });
  }

  // READ: get notes from database
  Stream<QuerySnapshot> getNotesStream() {
    final notesStream = employes.orderBy('Employee').snapshots();

    return notesStream;
  }

  // UPDATE: update notes given a doc id
  Future<void> updateNote(String docID, String newEmployee) {
    return employes.doc(docID).update({
      'Employee': newEmployee,
    });
  }

  // DELETE: delete notes given a doc id
  Future<void> deleteNote(String docID) {
    return employes.doc(docID).delete();
  }
}
