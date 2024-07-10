import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/features/home/presentation/cubits/fetch_notes_cubit/fetch_notes_cubit.dart';
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
            child: ListView.separated(
          itemBuilder: (context, index) =>  ListViewItem(note: state.notes[index],),
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              height: 16,
            );
          },
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
