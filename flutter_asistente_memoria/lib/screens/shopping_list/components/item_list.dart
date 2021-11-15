import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/bloc/shopping_list/shopping_list_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'item.dart';

class ItemList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShoppingListBloc, ShoppingListState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        if (state.status == ShoppingListStatus.shoppingListLoadedSuccessfully) {
          var shoppingList = <Widget>[];
          var cartList = <Widget>[];

          state.shoppingList.forEach((i) {
            Item item = new Item(itemModel: i, cart: false);
            shoppingList.add(item);
            shoppingList.add(new SizedBox(height: 10,));
          });

          state.cartList.forEach((i) {
            Item item = new Item(itemModel: i, cart: true);
            cartList.add(item);
            cartList.add(new SizedBox(height: 10,));
          });

          return Column(
            children: [
              Text("Lista de la Compra"),
              Column(
                children: shoppingList,
              ),
              Text("Carrito"),
              Column(
                children: cartList,
              ),
            ],
          );
        } else {
          return Text('Cargando lista de la compra');
        }
      },
    );
  }
}