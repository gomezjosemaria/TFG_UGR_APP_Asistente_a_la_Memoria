import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/bloc/alarms/alarms_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'alarm.dart';

class AlarmList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlarmsBloc, AlarmsState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        if (state.status == AlarmsStatus.alarmsLoadedSuccessfully) {
          var listActivated = <Widget>[];
          var listDeactivated = <Widget>[];

          state.alarmsActivated.forEach((i) {
            Alarm alarm = new Alarm(alarmModel: i, activated: true);
            listActivated.add(alarm);
            listActivated.add(new SizedBox(height: 10,));
          });

          state.alarmsDeactivated.forEach((i) {
            Alarm alarm = new Alarm(alarmModel: i, activated: false);
            listDeactivated.add(alarm);
            listDeactivated.add(new SizedBox(height: 10,));
          });

          return Column(
            children: [
              Text("Activas"),
              Column(
                children: listActivated,
              ),
              Text("Desactivadas"),
              Column(
                children: listDeactivated,
              ),
            ],
          );
        } else {
          return Text('Cargando alarmas');
        }
      },
    );
  }
}
