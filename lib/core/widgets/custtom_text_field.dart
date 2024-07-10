import 'package:flutter/material.dart';
import 'package:notes_app/core/utiles/app_colors.dart';
import 'package:notes_app/core/utiles/font.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key, required this.label, required this.controller,this.validator,
  });
   final String label;
 final TextEditingController controller;
 final String? Function(String?)? validator;
  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final FocusNode _focusNode = FocusNode();
  Color _fillColor = Colors.transparent;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
         _fillColor = _focusNode.hasFocus ?  AppColors.kItemBackgroundColor : Colors.transparent;
      });
     
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextFormField(
        controller: widget.controller,
            focusNode: _focusNode,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.mail_outline),
              label: Text(
                widget.label,
                style: FontStyles.kSmallTextStyle(context).copyWith(color: Colors.white70),
              ),
              enabledBorder:const OutlineInputBorder(
                borderSide:  BorderSide(color: Colors.transparent),
              ),
              focusedBorder: OutlineInputBorder(
                 borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(18),
              ),
              filled: true,
              fillColor: _fillColor,
            ),
            validator: widget.validator,
        ),
      );
  }
}