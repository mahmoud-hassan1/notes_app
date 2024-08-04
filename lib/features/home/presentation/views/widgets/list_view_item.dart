import 'package:flutter/material.dart';
import 'package:notes_app/core/utiles/app_colors.dart';
import 'package:notes_app/core/utiles/font.dart';
import 'package:notes_app/features/create_update_task/presentation/views/edit_view.dart';
import 'package:notes_app/features/home/data/models/note_model.dart';

class ListViewItem extends StatelessWidget {
   const ListViewItem({
    super.key, required this.note,
  });
 final NoteModel note;
  @override
  Widget build(BuildContext context) {
    return Stack(
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
                  maxLines: null,
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  note.content,
                  style: FontStyles.kSmallTextStyle(context).copyWith(),
                  maxLines: null,
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
    );
  }
}