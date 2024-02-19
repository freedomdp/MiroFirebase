import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'directory_event.dart';
import 'directory_state.dart';

class DirectoryBloc extends Bloc<DirectoryEvent, DirectoryState> {
  DirectoryBloc() : super(DirectoryInitial()) {
    on<LoadDirectories>((event, emit) {
      // Загрузка данных
    });
    on<DeleteDirectory>(_onDeleteDirectory);
    on<EditDirectory>(_onEditDirectory);
  }

  Future<void> _onDeleteDirectory(DeleteDirectory event, Emitter<DirectoryState> emit) async {
    emit(DirectoryLoading());
    try {
      await FirebaseFirestore.instance.collection('directory').doc(event.documentId).delete();
      emit(DirectoryLoaded()); // Возможно, потребуется обновленное состояние с новыми данными
    } catch (e) {
      emit(DirectoryError(e.toString()));
    }
  }

  Future<void> _onEditDirectory(EditDirectory event, Emitter<DirectoryState> emit) async {
    // Логика редактирования
  }
}
