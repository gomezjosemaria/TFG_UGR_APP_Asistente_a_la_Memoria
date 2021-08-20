import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/model/alarm.dart';

class Alarm extends StatelessWidget {

  const Alarm({Key? key, required this.alarmModel, required this.activated}) : super(key: key);

  final AlarmModel alarmModel;
  final bool activated;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Colors.blue,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(alarmModel.time),
              Switch(value: activated, onChanged: null),
            ],
          ),
          Text(alarmModel.tittle),
        ],
      ),
    );
  }
}