import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/screens/add_alarm/add_alarm.dart';

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
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddAlarm()));
        },
        child: Text("Añadir Alarma"),
      ),
    );
  }
}