import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/bloc/edit_item/edit_item_bloc.dart';
import 'package:flutter_asistente_memoria/model/item_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/body.dart';

class EditItem extends StatelessWidget {

  final ItemModel itemModel;

  const EditItem({Key? key, required this.itemModel}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Producto', style: TextStyle(fontSize: 25)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: BlocProvider(
            create: (context) => EditItemBloc()..add(EditItemStarted(itemModel)),
            child: Body(itemModel: itemModel,),
          ),
        ),
      ),
    );
  }
}