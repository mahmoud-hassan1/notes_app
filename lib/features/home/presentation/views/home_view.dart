import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/features/home/data/data_source/firestore_note_data_source.dart';
import 'package:notes_app/features/home/data/repositories/note_repo_impl.dart';
import 'package:notes_app/features/home/presentation/manger/fetch_notes_cubit/fetch_notes_cubit.dart';
import 'package:notes_app/features/create_update_task/presentation/views/add_view.dart';
import 'package:notes_app/features/home/presentation/views/widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key, required this.uid});
  final String uid;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FetchNotesCubit>(
      create: (context) {
        final cubit = FetchNotesCubit(
          NoteRepositoryImpl(
            dataSource:
                FirestoreNoteDataSource(firestore: FirebaseFirestore.instance),
          ),
        );
        cubit.fetchNotes(uid);
        return cubit;
      },
      child: HomeViewContent(uid: uid),
    );
  }
}

class HomeViewContent extends StatelessWidget {
  const HomeViewContent({super.key, required this.uid});
  final String uid;

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    final ValueNotifier<bool> showFabNotifier = ValueNotifier(false);

    scrollController.addListener(() {
      if (scrollController.position.pixels > 0) {
        showFabNotifier.value = true;
      } else {
        showFabNotifier.value = false;
      }
    });

    return Scaffold(
      body: HomeViewBody(scrollController: scrollController, showFabNotifier: showFabNotifier,),
      floatingActionButton: ValueListenableBuilder<bool>(
        valueListenable: showFabNotifier,
        builder: (context, showFab, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              showFab
                  ? FloatingActionButton(
                      onPressed: () {
                        scrollController.animateTo(
                          0.0,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeOut,
                        );
                      },
                      mini: true, 
                      heroTag: 'scrollToTop', 
                      child: const Icon(Icons.arrow_upward),
                    )
                  : Container(),
                 const SizedBox(height: 8,),
              FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddView(uid: uid),
                    ),
                  );
                },
                heroTag: 'addNote', 
                child: const Icon(Icons.add),
              ),
            ],
          );
        },
      ),
    );
  }
}