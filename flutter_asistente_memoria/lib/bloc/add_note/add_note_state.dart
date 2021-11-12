part of 'add_note_bloc.dart';

class AddNoteState extends Equatable {

  const AddNoteState({
    this.status = FormzStatus.pure,
    this.textInput = const NameInput.pure(),
  });

  final FormzStatus status;
  final NameInput textInput;

  AddNoteState copyWith({
    FormzStatus? status,
    NameInput? textInput,
  }) {
    return AddNoteState(
      status: status ?? this.status,
      textInput: textInput ?? this.textInput,
    );
  }

  @override
  List<Object> get props => [status, textInput];
}