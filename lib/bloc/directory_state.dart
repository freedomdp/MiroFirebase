abstract class DirectoryState {}

class DirectoryInitial extends DirectoryState {}

class DirectoryLoading extends DirectoryState {}

class DirectoryLoaded extends DirectoryState {
  // Здесь можно добавить данные, загруженные из Firestore
}

class DirectoryError extends DirectoryState {
  final String error;

  DirectoryError(this.error);
}
