import 'package:flutter/material.dart';
import 'package:notes_app/core/utiles/app_colors.dart';
import 'package:notes_app/core/utiles/font.dart';

 snackBar({required content,required context}){
    ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  content,
                  style: FontStyles.kSmallTextStyle(context),
                  ),
                backgroundColor: AppColors.kItemBackgroundColor,
              ),
            );
}