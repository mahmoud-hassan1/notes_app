import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/features/home/data/data_source/firestore_note_data_source.dart';
import 'package:notes_app/features/home/data/repositories/note_repo_impl.dart';
import 'package:notes_app/features/home/presentation/cubits/fetch_notes_cubit/fetch_notes_cubit.dart';
import 'package:notes_app/features/home/presentation/views/add_view.dart';
import 'package:notes_app/features/home/presentation/views/widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key, required this.uid});
  final String uid;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<FetchNotesCubit>(
      create: (context) {
        final cubit= FetchNotesCubit(NoteRepositoryImpl(dataSource: FirestoreNoteDataSource(firestore: FirebaseFirestore.instance)));
        cubit.fetchNotes(uid);
        return cubit;
        },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text(
            "Notes",
          ),
          centerTitle: true,
        ),
        body: const HomeViewBody(),
        floatingActionButton: FloatingActionButton(
          onPressed: () { 
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AddView(),));
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}