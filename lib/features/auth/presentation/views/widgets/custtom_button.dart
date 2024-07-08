import 'package:flutter/material.dart';
import 'package:notes_app/core/utiles/app_colors.dart';
import 'package:notes_app/core/utiles/font.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.height, required this.label,
  });
  final String label;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height*.09,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 64),
        child: ElevatedButton(
         onPressed: (){}, 
          style: ElevatedButton.styleFrom(
             backgroundColor: AppColors.kMintGreen
             
          ),
           child: Text(label,
            style: FontStyles.kMediumTextStyle(context).copyWith(
             color: Colors.black
             )
          ),
          ),
      ),
    );
  }
}

