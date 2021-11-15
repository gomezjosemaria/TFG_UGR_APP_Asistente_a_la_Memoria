part of 'edit_item_bloc.dart';

class EditItemState extends Equatable {

  const EditItemState({
    this.status = FormzStatus.pure,
    this.nameInput = const NameInput.pure(),
  });

  final FormzStatus status;
  final NameInput nameInput;

  EditItemState copyWith({
    FormzStatus? status,
    NameInput? nameInput,
  }) {
    return EditItemState(
      status: status ?? this.status,
      nameInput: nameInput ?? this.nameInput,
    );
  }

  @override
  List<Object> get props => [status, nameInput];
}

class EditItemDeleteState extends EditItemState {}

class EditItemDeletingState extends EditItemState {}

class EditItemDeleteSuccessState extends EditItemState {}

class EditItemDeleteErrorState extends EditItemState {}
