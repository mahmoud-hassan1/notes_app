import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/core/utiles/app_colors.dart';
import 'package:notes_app/features/create_update_task/presentation/manger/edit_note_cubit/edit_note_cubit.dart';
import 'package:notes_app/features/create_update_task/presentation/views/widgets/edit_view_body.dart';
import 'package:notes_app/features/home/data/data_source/firestore_note_data_source.dart';
import 'package:notes_app/features/home/data/models/note_model.dart';
import 'package:notes_app/features/home/data/repositories/note_repo_impl.dart';

class EditView extends StatelessWidget {
  const EditView({super.key, required this.note});
  final NoteModel note;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditNoteCubit(NoteRepositoryImpl(dataSource:FirestoreNoteDataSource(firestore: FirebaseFirestore.instance) )),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Note'),
         backgroundColor: AppColors.kBackgroundColor,
          elevation: 0,
        ),
        body: EditViewBody(
          note: note,
        ),
      ),
    );
  }
}
