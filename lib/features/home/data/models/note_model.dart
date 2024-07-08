import 'package:cloud_firestore/cloud_firestore.dart';

class NoteModel {
  final String id;
  final String title;
  final String content;

  NoteModel({required this.id, required this.title, required this.content});

  factory NoteModel.fromFirestore(DocumentSnapshot doc) {
    return NoteModel(
      id: doc.id,
      title: doc['title'],
      content: doc['content'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
    };
  }
}