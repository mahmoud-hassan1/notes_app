import 'package:notes_app/features/home/domain/entities/note.dart';

abstract class NoteRepository {
  Future<void> addNote(Note note);
  Stream<List<Note>> getNotes(String uid);
  Future<void> updateNote(Note note);
  Future<void> deleteNote(String id);
}