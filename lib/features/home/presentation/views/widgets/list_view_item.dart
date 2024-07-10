import 'package:flutter/material.dart';
import 'package:notes_app/core/utiles/app_colors.dart';
import 'package:notes_app/core/utiles/font.dart';
import 'package:notes_app/features/home/domain/entities/note.dart';

class ListViewItem extends StatelessWidget {
   ListViewItem({
    super.key, required this.note,
  });
 final Note note;
  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}