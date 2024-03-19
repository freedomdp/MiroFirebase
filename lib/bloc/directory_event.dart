abstract class DirectoryEvent {}

class LoadDirectories extends DirectoryEvent {}

class DeleteDirectory extends DirectoryEvent {
  final String documentId;

  DeleteDirectory(this.documentId);
}

class EditDirectory extends DirectoryEvent {
  final String documentId;
  final String newName; // Добавляем новое поле для имени

  EditDirectory(this.documentId, this.newName);
}
class AddDirectory extends DirectoryEvent {
  final String newName;

  AddDirectory(this.newName);
}
