import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'directory_event.dart';
import 'directory_state.dart';

class DirectoryBloc extends Bloc<DirectoryEvent, DirectoryState> {
  DirectoryBloc() : super(DirectoryInitial()) {
    on<LoadDirectories>(_loadDirectories);
    on<DeleteDirectory>(_onDeleteDirectory);
    on<EditDirectory>(_onEditDirectory);
    on<AddDirectory>(
        _onAddDirectory); // Правильное добавление обработчика события AddDirectory
  }

  Future<void> _loadDirectories(
      LoadDirectories event, Emitter<DirectoryState> emit) async {
    emit(DirectoryLoading());
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('directory').get();
      final directories = snapshot.docs;
      print('Загружено сотрудников: ${directories.length}');
      directories.forEach((doc) => print(doc.data()));
      emit(DirectoryLoaded(
          directories)); // Передаем список документов в состояние
    } catch (e) {
      emit(DirectoryError(e.toString()));
    }
  }

  Future<void> _onDeleteDirectory(
      DeleteDirectory event, Emitter<DirectoryState> emit) async {
    emit(DirectoryLoading());
    try {
      await FirebaseFirestore.instance
          .collection('directory')
          .doc(event.documentId)
          .delete();
      _loadDirectories(
          LoadDirectories(), emit); // Повторно загружаем список сотрудников
    } catch (e) {
      emit(DirectoryError(e.toString()));
    }
  }

  Future<void> _onEditDirectory(
      EditDirectory event, Emitter<DirectoryState> emit) async {
    emit(DirectoryLoading());
    try {
      await FirebaseFirestore.instance
          .collection('directory')
          .doc(event.documentId)
          .update({
        'Employee': event.newName,
      });
      _loadDirectories(
          LoadDirectories(), emit); // Повторно загружаем список сотрудников
    } catch (e) {
      emit(DirectoryError(e.toString()));
    }
  }

  Future<void> _onAddDirectory(
      AddDirectory event, Emitter<DirectoryState> emit) async {
    emit(DirectoryLoading());
    try {
      await FirebaseFirestore.instance
          .collection('directory')
          .add({'Employee': event.newName});
      _loadDirectories(
          LoadDirectories(), emit); // Повторно загружаем список сотрудников
    } catch (e) {
      emit(DirectoryError(e.toString()));
    }
  }
}
