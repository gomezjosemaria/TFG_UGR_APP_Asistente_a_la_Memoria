import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/model/alarm.dart';
import 'package:flutter_asistente_memoria/screens/edit_alarm/components/edit_alarm_form.dart';

class Body extends StatelessWidget {

  final AlarmModel alarmModel;
  final bool activated;

  const Body({Key? key, required this.alarmModel, required this.activated}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SafeArea(
        child: Column(
          children: [
            EditAlarmForm(alarmModel: alarmModel, activated: activated,),
          ],
        ),
      ),
    );
  }
}