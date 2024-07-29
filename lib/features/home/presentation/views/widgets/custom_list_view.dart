// File: custom_list_view.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/core/widgets/snackbar.dart';
import 'package:notes_app/features/home/data/data_source/firestore_note_data_source.dart';
import 'package:notes_app/features/home/data/repositories/note_repo_impl.dart';
import 'package:notes_app/features/home/presentation/manger/fetch_notes_cubit/fetch_notes_cubit.dart';
import 'package:notes_app/features/home/presentation/views/widgets/list_view_item.dart';

class CustomListView extends StatelessWidget {
  const CustomListView({super.key, required this.showFabNotifier, required this.scrollController});
    final ValueNotifier<bool> showFabNotifier;
      final ScrollController scrollController;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchNotesCubit, FetchNotesState>(
      builder: (context, state) {
        if (state is FetchNotesLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is FetchNotesSuccess) {
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) => Dismissible(
               key: Key(state.notes[index].id),
            direction: DismissDirection.horizontal,
            background: const SizedBox(
              width: double.infinity,
              child: Center(
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
            ),
            onDismissed: (direction) {
              try{
               NoteRepositoryImpl(dataSource: FirestoreNoteDataSource(firestore: FirebaseFirestore.instance)).deleteNote(state.notes[index].id);
              if (scrollController.position.pixels == 0) {
                showFabNotifier.value = false; 
              }
              }
              catch(e){
                snackBar(content: "Something went wrong while removing note", context: context);
              }
            },
              child: ListViewItem(note: state.notes[index])
              ),
            itemCount: state.notes.length,
          );
        } else {
          return const Center(child: Text("Something went wrong"));
        }
      },
    );
  }
}
