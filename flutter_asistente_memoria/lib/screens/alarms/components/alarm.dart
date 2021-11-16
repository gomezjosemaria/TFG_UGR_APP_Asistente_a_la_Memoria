import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/model/alarm_model.dart';
import 'package:flutter_asistente_memoria/screens/edit_alarm/edit_alarm.dart';

class Alarm extends StatelessWidget {

  const Alarm({Key? key, required this.alarmModel, required this.activated}) : super(key: key);

  final AlarmModel alarmModel;
  final bool activated;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditAlarm(alarmModel: alarmModel, activated: activated,)));
        },
        child: Container(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(alarmModel.tittle, style: TextStyle(fontSize: 20)),
                  SizedBox(
                    width: 1,
                    height: 1,
                  ),
                ],
              ),
              Text(alarmModel.time, style: TextStyle(fontSize: 25)),
              SizedBox(
                width: double.infinity,
                height: 10.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}