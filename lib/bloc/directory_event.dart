abstract class DirectoryEvent {}

class LoadDirectories extends DirectoryEvent {}

class DeleteDirectory extends DirectoryEvent {
  final String documentId;

  DeleteDirectory(this.documentId);
}

class EditDirectory extends DirectoryEvent {
  final String documentId;
  // Здесь можно добавить другие поля, необходимые для редактирования

  EditDirectory(this.documentId);
}
