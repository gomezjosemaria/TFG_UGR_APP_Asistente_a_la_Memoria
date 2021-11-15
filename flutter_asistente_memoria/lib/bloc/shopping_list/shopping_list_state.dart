part of 'shopping_list_bloc.dart';

enum ShoppingListStatus {
  initial,
  shoppingListLoading,
  shoppingListLoadedSuccessfully,
  error,
  shoppingListMoving,
}

class ShoppingListState extends Equatable {

  const ShoppingListState({
    this.status = ShoppingListStatus.initial,
    this.shoppingList = const <ItemModel>[],
    this.cartList = const <ItemModel>[],
  });

  final ShoppingListStatus status;
  final List<ItemModel> shoppingList;
  final List<ItemModel> cartList;

  ShoppingListState copyWith({
    ShoppingListStatus? status,
    List<ItemModel>? shoppingList,
    List<ItemModel>? cartList,
  }) {
    return ShoppingListState(
      status: status ?? this.status,
      shoppingList: shoppingList ?? this.shoppingList,
      cartList: cartList ?? this.cartList,
    );
  }

  @override
  List<Object?> get props => [status, shoppingList, cartList];
}

class ShoppingListMoveState extends ShoppingListState {}

class ShoppingListMovingState extends ShoppingListState {}

class ShoppingListMovedSuccessState extends ShoppingListState {}

class ShoppingListMoveErrorState extends ShoppingListState {}