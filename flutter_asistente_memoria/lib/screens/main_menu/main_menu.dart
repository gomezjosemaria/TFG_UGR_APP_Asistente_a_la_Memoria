import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/screens/main_menu/components/body.dart';

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Body(),
      ),
    );
  }
}