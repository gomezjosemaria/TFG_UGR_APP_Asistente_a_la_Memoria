import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/bloc/add_item/add_item_bloc.dart';
import 'package:flutter_asistente_memoria/screens/shopping_list/shopping_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/body.dart';

class AddItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Añadir Producto', style: TextStyle(fontSize: 25)),
        leading:
        IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => ShoppingList()));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: BlocProvider(
            create: (context) => AddItemBloc(),
            child: Body(),
          ),
        ),
      ),
    );
  }
}