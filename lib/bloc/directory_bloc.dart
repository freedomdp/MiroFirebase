import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'directory_event.dart';
import 'directory_state.dart';

class DirectoryBloc extends Bloc<DirectoryEvent, DirectoryState> {
  DirectoryBloc() : super(DirectoryInitial()) {
    on<LoadDirectories>((event, emit) => _loadDirectories(emit));
    on<DeleteDirectory>(_onDeleteDirectory);
    on<EditDirectory>(_onEditDirectory);
  }

  Future<void> _loadDirectories(Emitter<DirectoryState> emit) async {
    // Загрузка данных
  }

  Future<void> _onDeleteDirectory(DeleteDirectory event, Emitter<DirectoryState> emit) async {
    emit(DirectoryLoading());
    try {
      await FirebaseFirestore.instance.collection('directory').doc(event.documentId).delete();
      emit(DirectoryLoaded()); // Обновляем состояние после удаления
    } catch (e) {
      emit(DirectoryError(e.toString()));
    }
  }

  Future<void> _onEditDirectory(EditDirectory event, Emitter<DirectoryState> emit) async {
    emit(DirectoryLoading());
    try {
      await FirebaseFirestore.instance.collection('directory').doc(event.documentId).update({
        'Employee': event.newName,
      });
      emit(DirectoryLoaded()); // Обновляем состояние после редактирования
    } catch (e) {
      emit(DirectoryError(e.toString()));
    }
  }
}
