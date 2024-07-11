import 'package:bloc/bloc.dart';

import 'package:notes_app/features/home/data/repositories/note_repo_impl.dart';
import 'package:notes_app/features/home/domain/entities/note.dart';

part 'fetch_notes_state.dart';

class FetchNotesCubit extends Cubit<FetchNotesState> {
  final NoteRepositoryImpl repo;
  FetchNotesCubit(this.repo) : super(FetchNotesInitial());
  void fetchNotes(String uid)async{
    emit(FetchNotesLoading());
    try{
    final notes = await repo.getNotes(uid);
    emit(FetchNotesSuccess(notes: notes));
    }
    catch (e){
      emit(FetchNotesFailed());
    }

  }
}
