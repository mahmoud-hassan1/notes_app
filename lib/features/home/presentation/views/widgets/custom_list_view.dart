import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/features/home/presentation/manger/fetch_notes_cubit/fetch_notes_cubit.dart';
import 'package:notes_app/features/home/presentation/views/widgets/list_view_item.dart';

class CustomListView extends StatelessWidget {
  const CustomListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchNotesCubit, FetchNotesState>(
      builder: (context, state) {
        if(state is FetchNotesLoading){
         return const Center(child: CircularProgressIndicator(),);
        }
        else if (state is FetchNotesSuccess){
          return Expanded(
            child: ListView.builder(
          itemBuilder: (context, index) =>  ListViewItem(note: state.notes[index],
          ),
          itemCount: state.notes.length,
        ));
          
        }
        else{
          return const Center(child: Text("Something went wrong"),);
        
        }
      },
    );
  }
}
