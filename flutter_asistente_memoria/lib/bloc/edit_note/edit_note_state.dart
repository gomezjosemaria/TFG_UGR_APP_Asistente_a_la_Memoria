part of 'edit_note_bloc.dart';

class EditNoteState extends Equatable {

  const EditNoteState({
    this.status = FormzStatus.pure,
    this.textInput = const NameInput.pure(),
  });

  final FormzStatus status;
  final NameInput textInput;

  EditNoteState copyWith({
    FormzStatus? status,
    NameInput? textInput,
  }) {
    return EditNoteState(
      status: status ?? this.status,
      textInput: textInput ?? this.textInput,
    );
  }

  @override
  List<Object> get props => [status, textInput];
}

class EditNoteDeleteState extends EditNoteState {}

class EditNoteDeletingState extends EditNoteDeleteState {}

class EditNoteDeleteSuccessState extends EditNoteDeleteState {}

class EditNoteDeleteErrorState extends EditNoteDeleteState {}