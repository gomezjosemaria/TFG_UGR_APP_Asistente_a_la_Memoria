import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/screens/second_menu/second_menu.dart';

class NextMenuButton extends StatelessWidget {
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
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => SecondMenu()));
        },
        child: Icon(
          Icons.arrow_right,
          size: 50,
        ),
      ),
    );
  }
}