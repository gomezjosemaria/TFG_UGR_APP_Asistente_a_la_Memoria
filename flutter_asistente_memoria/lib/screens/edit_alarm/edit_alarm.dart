import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/bloc/edit_alarm/edit_alarm_bloc.dart';
import 'package:flutter_asistente_memoria/model/alarm_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/body.dart';

class EditAlarm extends StatelessWidget {

  final AlarmModel alarmModel;
  final bool activated;

  const EditAlarm({Key? key, required this.alarmModel, required this.activated}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Alarma', style: TextStyle(fontSize: 25)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: BlocProvider(
          create: (context) => EditAlarmBloc()..add(EditAlarmStarted(alarmModel, activated)),
          child: Body(alarmModel: alarmModel, activated: activated,),
        ),
      ),
    );
  }
}