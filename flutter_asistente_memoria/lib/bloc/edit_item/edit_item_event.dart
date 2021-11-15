part of 'edit_item_bloc.dart';

abstract class EditItemEvent extends Equatable {
  const EditItemEvent();
}

class EditItemStarted extends EditItemEvent {
  final ItemModel item;

  EditItemStarted(this.item);

  @override
  List<Object?> get props => [item];
}

class EditItemNameChanged extends EditItemEvent {
  final String nameInput;

  EditItemNameChanged(this.nameInput);

  @override
  List<Object?> get props => [nameInput];
}

class EditItemSubmitted extends EditItemEvent {
  final ItemModel itemUnmodified;

  EditItemSubmitted(this.itemUnmodified);

  @override
  List<Object> get props => [itemUnmodified];
}

class EditItemDelete extends EditItemEvent {
  final ItemModel itemUnmodified;

  EditItemDelete(this.itemUnmodified);

  @override
  List<Object> get props => [itemUnmodified];
}