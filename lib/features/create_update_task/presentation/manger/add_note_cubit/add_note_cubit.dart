import 'package:bloc/bloc.dart';
import 'package:notes_app/features/home/data/repositories/note_repo_impl.dart';

part 'add_note_state.dart';

class AddNoteCubit extends Cubit<AddNoteState> {
  AddNoteCubit(this.repo) : super(AddNoteInitial());
 final NoteRepositoryImpl repo;
  void addNote({required String title,required String content,required String uid}) {
    emit(AddNoteLoading());
    try{
      repo.addNote(title: title,content: content,uid: uid);
      emit(AddNoteSuccess());
    }
    catch(e){
      emit(AddNoteFailed());
    }
  }

}
