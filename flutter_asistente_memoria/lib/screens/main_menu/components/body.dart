import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/screens/main_menu/components/button_grid.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SafeArea(
        child: Column(
          children: [
            ButtonGrid(),
          ],
        ),
      ),
    );
  }
}