import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/screens/activities/activities.dart';
import 'package:flutter_asistente_memoria/screens/main_menu/components/menu_button.dart';
import 'package:flutter_asistente_memoria/screens/shopping_list/shopping_list.dart';


class ButtonGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      children: [
        MenuButton(
          title: 'Actividades',
          icon: Icons.directions_run,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Activities()));
          },
        ),
        MenuButton(
          title: 'Lista de la Compra',
          icon: Icons.shopping_cart,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => ShoppingList()));
          },
        ),
      ],
    );
  }
}