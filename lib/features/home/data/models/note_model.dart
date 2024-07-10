import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes_app/features/home/domain/entities/note.dart';

class NoteModel extends Note{

  NoteModel({
    required super.uid,
    required super.id,
    required super.title,
    required super.content,
  }) ;

  factory NoteModel.fromFirestore(DocumentSnapshot doc) {
    return NoteModel(
      id: doc.id,
      title: doc['title'],
      content: doc['content'],
       uid: doc['uid'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
    };
  }
}