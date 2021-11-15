part of 'add_item_bloc.dart';

class AddItemState extends Equatable {

  const AddItemState({
    this.status = FormzStatus.pure,
    this.nameInput = const NameInput.pure(),
  });

  final FormzStatus status;
  final NameInput nameInput;

  AddItemState copyWith({
    FormzStatus? status,
    NameInput? nameInput,
  }) {
    return AddItemState(
      status: status ?? this.status,
      nameInput: nameInput ?? this.nameInput,
    );
  }

  @override
  List<Object> get props => [status, nameInput,];
}
