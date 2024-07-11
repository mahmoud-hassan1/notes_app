import 'package:flutter/material.dart';
import 'package:notes_app/core/utiles/font.dart';
class CustomUpdateButton extends StatelessWidget {
  const CustomUpdateButton({
    super.key,

    required this.onPressed, required this.title,
  });

  final VoidCallback onPressed;
  final String title;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueGrey.shade200
          ),
          child:  Text(title,
          style: FontStyles.kSmallTextStyle(context).copyWith(color: Colors.black), 
          ),
        ),
      ),
    );
  }
}
