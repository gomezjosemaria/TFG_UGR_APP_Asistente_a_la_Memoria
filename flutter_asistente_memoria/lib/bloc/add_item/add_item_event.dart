part of 'add_item_bloc.dart';

abstract class AddItemEvent extends Equatable {
  const AddItemEvent();
}

class AddItemNameChanged extends AddItemEvent {
  final String nameInput;

  AddItemNameChanged(this.nameInput);

  @override
  List<Object?> get props => [nameInput];
}

class AddItemSubmitted extends AddItemEvent {
  const AddItemSubmitted();

  @override
  List<Object> get props => [];
}