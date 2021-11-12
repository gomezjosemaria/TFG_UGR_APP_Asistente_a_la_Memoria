import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/screens/main_menu/main_menu.dart';

class PreviousMenuButton extends StatelessWidget {
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
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => MainMenu()));
        },
        child: Icon(
          Icons.arrow_left,
          size: 50,
        ),
      ),
    );
  }
}