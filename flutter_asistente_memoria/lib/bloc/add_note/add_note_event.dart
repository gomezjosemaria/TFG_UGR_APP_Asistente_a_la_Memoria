part of 'add_note_bloc.dart';

abstract class AddNoteEvent extends Equatable {
  const AddNoteEvent();
}

class AddNoteTextChanged extends AddNoteEvent {
  final String textInput;

  AddNoteTextChanged(this.textInput);

  @override
  List<Object?> get props => [textInput];
}

class AddNoteSubmitted extends AddNoteEvent {
  const AddNoteSubmitted();

  @override
  List<Object> get props => [];
}