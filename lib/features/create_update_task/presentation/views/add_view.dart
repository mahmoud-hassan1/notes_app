import 'package:flutter/material.dart';
import 'package:notes_app/core/widgets/custtom_text_field.dart';

class AddView extends StatelessWidget {
   AddView({super.key});
  TextEditingController titleController =  TextEditingController();
    TextEditingController contentController =  TextEditingController();
      GlobalKey<FormState> keyForm = GlobalKey();
        AutovalidateMode mode = AutovalidateMode.always;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Add Note'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: keyForm,
          autovalidateMode: mode,
          child: Column(
            children: [
              CustomTextField(
                controller: titleController,
                label: 'Title',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              CustomTextField(
                controller: contentController,
                label: 'Content',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some content';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () {
                      if(keyForm.currentState!.validate()){
                        
                    }
                },
                child: const Text('Add Note'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}