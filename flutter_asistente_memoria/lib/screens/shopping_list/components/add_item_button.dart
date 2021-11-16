import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/screens/add_item/add_item.dart';

class AddItemButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60.0,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: StadiumBorder(),
        ),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddItem()));
        },
        child: Text("Añadir Producto", style: TextStyle(fontSize: 25)),
      ),
    );
  }
}