part of 'edit_note_bloc.dart';

abstract class EditNoteEvent extends Equatable {
  const EditNoteEvent();
}

class EditNoteStarted extends EditNoteEvent {
  final NoteModel note;

  EditNoteStarted(this.note);

  @override
  List<Object?> get props => [note];
}

class EditNoteTextChanged extends EditNoteEvent {
  final String textInput;

  EditNoteTextChanged(this.textInput);

  @override
  List<Object?> get props => [textInput];
}

class EditNoteSubmitted extends EditNoteEvent {
  final NoteModel noteUnmodified;

  EditNoteSubmitted(this.noteUnmodified);

  @override
  List<Object> get props => [noteUnmodified];
}

class EditNoteDelete extends EditNoteEvent {
  final NoteModel noteUnmodified;

  EditNoteDelete(this.noteUnmodified);

  @override
  List<Object> get props => [noteUnmodified];
}