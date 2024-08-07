import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:notes_app/core/widgets/custtom_text_field.dart';
import 'package:notes_app/core/widgets/snackbar.dart';
import 'package:notes_app/features/create_update_task/presentation/manger/add_note_cubit/add_note_cubit.dart';
import 'package:notes_app/features/create_update_task/presentation/views/widgets/custom_update_button.dart';
import 'package:notes_app/features/home/presentation/views/home_view.dart';

// ignore: must_be_immutable
class AddViewBody extends StatelessWidget {
  AddViewBody({
    super.key,
    required this.uid,
  });
  final String uid;
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  GlobalKey<FormState> keyForm = GlobalKey();
  AutovalidateMode mode = AutovalidateMode.always;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddNoteCubit, AddNoteState>(
      listener: (context, state) {
        if (state is AddNoteFailed) {
          snackBar(content: "Something Went Wrong", context: context);
          isLoading = false;
        } else if (state is AddNoteLoading) {
          isLoading = true;
        } else if (state is AddNoteSuccess) {
          snackBar(content: "Note Added Successfully", context: context);
          isLoading = false;
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => HomeView(uid: uid),
              ),
              (Route<dynamic> route) => false);
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: ModalProgressHUD(
            inAsyncCall: isLoading,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: keyForm,
                autovalidateMode: mode,
                child: Column(
                  children: [
                    CustomTextField(
                      validate: true,
                      prefixIcon: const Icon(Icons.note_alt_outlined),
                      controller: titleController,
                      label: 'Title',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextField(
                      prefixIcon: const Icon(Icons.note_alt_outlined),
                      controller: contentController,
                      label: 'Content',
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomUpdateButton(
                        title: "Add Note",
                        onPressed: () {
                           if (keyForm.currentState!.validate()) {
                          BlocProvider.of<AddNoteCubit>(context).addNote(
                            title: titleController.text,
                            content: contentController.text,
                            uid: uid,
                          );
                        }
                      }
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
