import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/screens/alarms/alarms.dart';
import 'package:flutter_asistente_memoria/screens/main_menu/components/menu_button.dart';

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
          title: 'Perfil',
          icon: Icons.account_circle,
          onPressed: () => null,
        ),
        MenuButton(
          title: 'Alarmas',
          icon: Icons.alarm,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Alarms()));
          },
        ),
      ],
    );
  }
}