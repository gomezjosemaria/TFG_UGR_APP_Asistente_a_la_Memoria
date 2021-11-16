import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/model/alarm_model.dart';

class PlannerAlarm extends StatelessWidget {

  const PlannerAlarm({Key? key, required this.alarmModel, required this.activated}) : super(key: key);

  final AlarmModel alarmModel;
  final bool activated;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
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
                  Icon(
                    Icons.alarm,
                    size: 25,
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