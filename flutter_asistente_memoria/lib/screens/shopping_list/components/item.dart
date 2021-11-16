import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/bloc/shopping_list/shopping_list_bloc.dart';
import 'package:flutter_asistente_memoria/model/item_model.dart';
import 'package:flutter_asistente_memoria/screens/edit_item/edit_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shopping_list.dart';

class Item extends StatelessWidget {
  const Item({Key? key, required this.itemModel, required this.cart})
      : super(key: key);

  final ItemModel itemModel;
  final bool cart;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShoppingListBloc, ShoppingListState>(
      listenWhen: (previous, current) =>
          previous is ShoppingListState &&
          current is ShoppingListState &&
          previous != current,
      listener: (context, state) {
        if (state is ShoppingListMovedSuccessState) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => ShoppingList()));
        }
      },
      buildWhen: (previous, current) =>
          previous is ShoppingListState &&
          current is ShoppingListState &&
          previous != current,
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          height: 60.0,
          child: Row(
            children: <Widget>[
              Expanded(
                child: ElevatedButton(
                  onPressed: state is ShoppingListMovingState
                      ? null
                      : () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  EditItem(itemModel: itemModel)));
                        },
                  child: Container(
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 15.0,
                        ),
                        Text(itemModel.name, style: TextStyle(fontSize: 25)),
                        SizedBox(
                          width: double.infinity,
                          height: 10.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 40,
                height: 40,
              ),
              SizedBox(
                width: 60.0,
                height: 60.0,
                child: Ink(
                  child: IconButton(
                    color: Theme.of(context).colorScheme.onPrimary,
                    padding: EdgeInsets.all(0),
                    icon: itemModel.cart
                        ? Icon(Icons.remove_shopping_cart, size: 40)
                        : Icon(Icons.add_shopping_cart, size: 40),
                    onPressed: state is ShoppingListMovingState
                        ? null
                        : () {
                            context
                                .read<ShoppingListBloc>()
                                .add(ShoppingListMove(itemModel));
                          },
                  ),
                  decoration: ShapeDecoration(
                    shape: CircleBorder(),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
