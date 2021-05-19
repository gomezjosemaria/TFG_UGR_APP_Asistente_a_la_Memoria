import 'package:flutter/material.dart';

class AddAlarmButton extends StatelessWidget {
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
        },
        child: Text("Añadir Alarma"),
      ),
    );
  }
}