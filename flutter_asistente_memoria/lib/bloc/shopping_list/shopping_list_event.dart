part of 'shopping_list_bloc.dart';

abstract class ShoppingListEvent extends Equatable {
  const ShoppingListEvent();
}

class ShoppingListStarted extends ShoppingListEvent {
  @override
  List<Object?> get props => [];
}

class ShoppingListMove extends ShoppingListEvent {
  final ItemModel itemModel;

  ShoppingListMove(this.itemModel);

  @override
  List<Object?> get props => [itemModel];
}
