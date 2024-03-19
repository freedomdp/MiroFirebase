import 'package:cloud_firestore/cloud_firestore.dart';

abstract class DirectoryState {}

class DirectoryInitial extends DirectoryState {}

class DirectoryLoading extends DirectoryState {}

class DirectoryLoaded extends DirectoryState {
  final List<DocumentSnapshot> directories;

  DirectoryLoaded(this.directories);
}

class DirectoryError extends DirectoryState {
  final String error;

  DirectoryError(this.error);
}
