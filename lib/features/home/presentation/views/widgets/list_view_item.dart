import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/core/utiles/app_colors.dart';
import 'package:notes_app/core/utiles/font.dart';
import 'package:notes_app/core/widgets/snackbar.dart';
import 'package:notes_app/features/create_update_task/presentation/views/edit_view.dart';
import 'package:notes_app/features/home/data/data_source/firestore_note_data_source.dart';
import 'package:notes_app/features/home/data/models/note_model.dart';
import 'package:notes_app/features/home/data/repositories/note_repo_impl.dart';
import 'package:notes_app/features/home/domain/entities/note.dart';

class ListViewItem extends StatelessWidget {
   const ListViewItem({
    super.key, required this.note,
  });
 final NoteModel note;
  @override
  Widget build(BuildContext context) {
    return Dismissible(
           key: Key(note.id),
            direction: DismissDirection.horizontal,
            background: const SizedBox(
              width: double.infinity,
              child: Center(
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
            ),
            onDismissed: (direction) {
              try{
               NoteRepositoryImpl(dataSource: FirestoreNoteDataSource(firestore: FirebaseFirestore.instance)).deleteNote(note.id);
              }
              catch(e){
                snackBar(content: "Something went wrong while removing note", context: context);
              }
            },
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            width: double.infinity,
            decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.kItemBackgroundColor
            ),
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 20),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    note.title,
                    style: FontStyles.kFontSize30(context).copyWith(),
                    textAlign: TextAlign.start,
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    note.content,
                    style: FontStyles.kSmallTextStyle(context).copyWith(),
                    maxLines: 2,
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
              ) ,
          ),
          Positioned(
            right: 0,
            height: 32,
            child: IconButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => EditView(note: note),));
              }, icon: const Icon(
              Icons.edit
            ),
            padding: EdgeInsets.zero,
            ),
          )
        ],
      ),
    );
  }
}