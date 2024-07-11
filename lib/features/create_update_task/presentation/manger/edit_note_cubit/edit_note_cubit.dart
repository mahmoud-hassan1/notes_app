import 'package:bloc/bloc.dart';
import 'package:notes_app/features/home/data/models/note_model.dart';
import 'package:notes_app/features/home/data/repositories/note_repo_impl.dart';

part 'edit_note_state.dart';

class EditNoteCubit extends Cubit<EditNoteState> {
  EditNoteCubit(this.repo) : super(EditNoteInitial());
   final NoteRepositoryImpl repo;
  void editNote({required NoteModel note}) {
    emit(EditNoteLoading());
    try{
      repo.updateNote(note);
      emit(EditNoteSuccess());
    }
    catch(e){
      emit(EditNoteFailed());
    }
  }

}
