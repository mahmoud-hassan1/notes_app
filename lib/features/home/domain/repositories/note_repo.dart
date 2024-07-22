import 'package:notes_app/features/home/data/models/note_model.dart';

abstract class NoteRepository {
  Future<void> addNote({required String title,required String content,required String uid});
  Future<List<NoteModel>> getNotes(String uid);
  Future<void> updateNote(NoteModel note);
  Future<void> deleteNote(String id);
}