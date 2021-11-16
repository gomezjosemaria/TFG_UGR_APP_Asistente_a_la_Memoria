import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/bloc/edit_item/edit_item_bloc.dart';
import 'package:flutter_asistente_memoria/model/item_model.dart';
import 'package:flutter_asistente_memoria/screens/shopping_list/shopping_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteItemButton extends StatelessWidget {
  final ItemModel itemModel;

  const DeleteItemButton({Key? key, required this.itemModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditItemBloc, EditItemState>(
      listenWhen: (previous, current) => previous != current,
      listener: (context, state) {
        print (state);
        if (state is EditItemDeleteSuccessState) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ShoppingList()));
        }
      },
      buildWhen: (previous, current) =>
      previous is EditItemDeleteState && current is EditItemDeleteState && previous != current,
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          height: 60.0,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: StadiumBorder(),
            ),
            onPressed: state is EditItemDeletingState ? null : () {
              context.read<EditItemBloc>().add(EditItemDelete(itemModel));
            },
            child: state is EditItemDeletingState
                ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
                : Text("Eliminar", style: TextStyle(fontSize: 25)),
          ),
        );
      },
    );
  }
}