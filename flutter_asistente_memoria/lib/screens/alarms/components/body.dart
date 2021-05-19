import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/screens/alarms/components/add_alarm_button.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SafeArea(
        child: Column(
          children: [
            AddAlarmButton(),
          ],
        ),
      ),
    );
  }
}