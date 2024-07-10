import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes_app/features/home/data/models/note_model.dart';

class FirestoreNoteDataSource {
  final FirebaseFirestore firestore;

  FirestoreNoteDataSource({required this.firestore});

  Future<void> addNote(NoteModel note) async {
    await firestore.collection('notes').add(note.toMap());
  }

  Stream<List<NoteModel>> getNotes(String uid) {
    return firestore.collection('notes')
      .where('uid', isEqualTo: uid)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => NoteModel.fromFirestore(doc)).toList());
  }
  Future<void> deleteNote(String id) async{
      await firestore.collection('notes').doc(id).delete();
  }
   Future<void> updateNote(NoteModel note) async{
      await firestore.collection('notes').doc(note.id).update(note.toMap());
    }
}