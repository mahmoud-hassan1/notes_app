import 'package:notes_app/features/home/data/data_source/firestore_note_data_source.dart';
import 'package:notes_app/features/home/data/models/note_model.dart';
import 'package:notes_app/features/home/domain/entities/note.dart';
import 'package:notes_app/features/home/domain/repositories/note_repo.dart';

class NoteRepositoryImpl implements NoteRepository {
  final FirestoreNoteDataSource dataSource;

  NoteRepositoryImpl({required this.dataSource});

  @override
  Future<void> addNote(Note note) {
    return dataSource.addNote(NoteModel(id: note.id, title: note.title, content: note.content, uid: note.uid));
  }

  @override
  Stream<List<Note>> getNotes(String uid) {
    return dataSource.getNotes(uid).map((noteModels) => 
      noteModels.map((model) => Note(
        id: model.id,
        title: model.title,
        content: model.content,
         uid: model.uid,
      )).toList()
    );
  }
  
  @override
  Future<void> deleteNote(String id) async{
   await dataSource.deleteNote(id);
  }
  
  @override
  Future<void> updateNote(Note note) async{

   await dataSource.updateNote(NoteModel(id: note.id, title: note.title, content: note.content, uid: note.uid));
  }

}