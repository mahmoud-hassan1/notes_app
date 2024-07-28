import 'package:flutter/material.dart';
import 'package:notes_app/core/utiles/app_colors.dart';
import 'package:notes_app/core/utiles/font.dart';

// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
   CustomTextField({
    super.key, required this.label, required this.controller,this.validator, required this.prefixIcon,this.obscure=false,  this.password=false,
  this.keyForm,this.validate=false, this.expand=true
  });
  final bool expand;
  final Icon prefixIcon;
  bool validate;
  final String label;
  final bool password;
  bool obscure;
 final TextEditingController controller;
   GlobalKey<FormState>? keyForm ;
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
         if(widget.keyForm!=null){
          widget.validate=true;
          widget.keyForm!.currentState!.validate();
      }
      });
     
    });
  }

  @override
  void dispose() {
    widget.controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextFormField(
        minLines: 1,
        maxLines: widget.expand? null:1,
        controller: widget.controller,
            focusNode: _focusNode,
            obscureText:widget.obscure ,
            decoration: InputDecoration(
              
              suffixIcon: widget.password?IconButton(onPressed: (){
                widget.obscure=!widget.obscure;
                setState(() {
                  
                });
              },
              
               icon: Icon(!widget.obscure?Icons.visibility_outlined:Icons.visibility_off_outlined )):null,
              prefixIcon:  widget.prefixIcon,
              
              label: Text(
                widget.label,
                style: FontStyles.kSmallTextStyle(context).copyWith(color: Colors.white70),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(18),
              ),
              
              focusedBorder: OutlineInputBorder(
                 borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(18),
              ),
             focusedErrorBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: const BorderSide(color: Colors.redAccent)
             ),
             errorBorder:const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.redAccent)
             ),
             errorStyle: const TextStyle(color: Colors.redAccent),
              filled: true,
              fillColor: _fillColor,
            ),
            validator:widget.validate? widget.validator:null,
        ),
      );
  }
}