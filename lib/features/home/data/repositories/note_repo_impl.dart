import 'package:notes_app/features/home/data/data_source/firestore_note_data_source.dart';
import 'package:notes_app/features/home/data/models/note_model.dart';

import 'package:notes_app/features/home/domain/repositories/note_repo.dart';

class NoteRepositoryImpl implements NoteRepository {
  final FirestoreNoteDataSource dataSource;

  NoteRepositoryImpl({required this.dataSource});

  @override
  Future<void> addNote({required String title,required String content,required String uid}) {
    return dataSource.addNote(content: content,title: title,uid: uid);
  }

  @override
  Future<List<NoteModel>> getNotes(String uid) async {
    final noteModels = await dataSource.getNotes(uid);
    return noteModels;
  }
  
  @override
  Future<void> deleteNote(String id) async{
   await dataSource.deleteNote(id);
  }
  
  @override
  Future<void> updateNote(NoteModel note) async{

   await dataSource.updateNote(note);
  }

}