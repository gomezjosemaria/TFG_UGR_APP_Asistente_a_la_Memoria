import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/model/item_model.dart';

import 'delete_item_button.dart';
import 'edit_item_form.dart';

class Body extends StatelessWidget {

  final ItemModel itemModel;

  const Body({Key? key, required this.itemModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SafeArea(
        child: Column(
          children: [
            EditItemForm(itemModel: itemModel),
            SizedBox(
              width: double.infinity,
              height: 20.0,
            ),
            DeleteItemButton(itemModel: itemModel),
          ],
        ),
      ),
    );
  }
}