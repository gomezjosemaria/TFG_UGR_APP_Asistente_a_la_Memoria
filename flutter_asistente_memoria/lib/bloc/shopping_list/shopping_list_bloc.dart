import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_asistente_memoria/functions/authentication.dart';
import 'package:flutter_asistente_memoria/functions/item_manager.dart';
import 'package:flutter_asistente_memoria/model/item_model.dart';
import 'package:flutter_asistente_memoria/model/user.dart';

part 'shopping_list_event.dart';
part 'shopping_list_state.dart';

class ShoppingListBloc extends Bloc<ShoppingListEvent, ShoppingListState> {
  ShoppingListBloc() : super(ShoppingListState());

  @override
  Stream<ShoppingListState> mapEventToState(ShoppingListEvent event) async* {
    if (event is ShoppingListStarted) {
      yield state.copyWith(status: ShoppingListStatus.shoppingListLoading);
      try {
        if (Authentication.getUserRole() == UserRole.caregiver) {
          await ItemManager.loadItems(Authentication.getUserBond());
        }
        else if (Authentication.getUserRole() == UserRole.careReceiver) {
          await ItemManager.loadItems(Authentication.getCurrentUserEmail());
        }
        yield state.copyWith(status: ShoppingListStatus.shoppingListLoadedSuccessfully, shoppingList: ItemManager.getItemsList(), cartList: ItemManager.getItemsCart());
      } catch (e) {
        yield state.copyWith(status: ShoppingListStatus.error);
      }
    }
    else if (event is ShoppingListMove) {
      yield* _mapShoppingListMoveToState(event, state);
    }
  }

  Stream<ShoppingListState> _mapShoppingListMoveToState(ShoppingListMove event, ShoppingListState state) async* {
    final String userEmail;
    yield state.copyWith(status: ShoppingListStatus.shoppingListMoving);

    if (Authentication.getUserRole() == UserRole.caregiver) {
      userEmail = Authentication.getUserBond();
    }
    else {
      userEmail = Authentication.getCurrentUser().email;
    }

    try {
      await ItemManager.moveItem(event.itemModel, userEmail);
      yield state.copyWith(status: ShoppingListStatus.shoppingListLoadedSuccessfully);
    } on Exception {
      yield state.copyWith(status: ShoppingListStatus.error);
    }
  }
}
