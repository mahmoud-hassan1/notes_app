part of 'fetch_notes_cubit.dart';

sealed class FetchNotesState {}

final class FetchNotesInitial extends FetchNotesState {}
final class FetchNotesLoading extends FetchNotesState {}
final class FetchNotesSuccess extends FetchNotesState {
  final List<NoteModel> notes;
  FetchNotesSuccess({required this.notes});
}
final class FetchNotesFailed extends FetchNotesState {}
