import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/features/create_update_task/presentation/manger/add_note_cubit/add_note_cubit.dart';
import 'package:notes_app/features/create_update_task/presentation/views/widgets/add_view_body.dart';
import 'package:notes_app/features/home/data/data_source/firestore_note_data_source.dart';
import 'package:notes_app/features/home/data/repositories/note_repo_impl.dart';

class AddView extends StatelessWidget {
  const AddView({super.key, required this.uid});
  final String uid;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddNoteCubit(NoteRepositoryImpl(dataSource:FirestoreNoteDataSource(firestore: FirebaseFirestore.instance) )),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Note'),
          backgroundColor: Colors.transparent,
          centerTitle: true,
        ),
        body: AddViewBody(
          uid: uid,
        ),
      ),
    );
  }
}
