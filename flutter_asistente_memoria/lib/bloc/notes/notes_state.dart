part of 'notes_bloc.dart';

enum NotesStatus {
  initial,
  notesLoading,
  notesLoadedSuccessfully,
  error
}

class NotesState extends Equatable {

  const NotesState({
    this.status = NotesStatus.initial,
    this.notes = const <NoteModel>[],
  });

  final NotesStatus status;
  final List<NoteModel> notes;

  NotesState copyWith({
    NotesStatus? status,
    List<NoteModel>? notes,
  }) {
    return NotesState(
      status: status ?? this.status,
      notes: notes ?? this.notes,
    );
  }

  @override
  List<Object?> get props => [status, notes];
}