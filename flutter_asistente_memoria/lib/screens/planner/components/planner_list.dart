import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/bloc/planner/planner_bloc.dart';
import 'package:flutter_asistente_memoria/functions/planner_manager.dart';
import 'package:flutter_asistente_memoria/model/alarm_model.dart';
import 'package:flutter_asistente_memoria/model/appointments_model.dart';
import 'package:flutter_asistente_memoria/model/medication_model.dart';
import 'package:flutter_asistente_memoria/screens/planner/components/planner_alarm.dart';
import 'package:flutter_asistente_memoria/screens/planner/components/planner_appointment.dart';
import 'package:flutter_asistente_memoria/screens/planner/components/planner_medication.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlannerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlannerBloc, PlannerState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          if (state.status == PlannerStatus.loadedSuccessfully) {
            List<Widget> widgets = <Widget>[];
            List<Object> order = PlannerManager.getOrderByTime();
            order.forEach((i) {
              if (i is AlarmModel) {
                PlannerAlarm plannerAlarm = new PlannerAlarm(alarmModel: i, activated: true);
                widgets.add(plannerAlarm);
                widgets.add(new SizedBox(height: 10,));
              }
              else if (i is MedicationModel) {
                PlannerMedication plannerMedication = new PlannerMedication(medicationModel: i, activated: true);
                widgets.add(plannerMedication);
                widgets.add(new SizedBox(height: 10,));
              }
              else if (i is AppointmentModel) {
                PlannerAppointment plannerAppointment = new PlannerAppointment(appointmentModel: i, activated: true);
                widgets.add(plannerAppointment);
                widgets.add(new SizedBox(height: 10,));
              }
            });
            return Column(
              children: [
                Text("Agenda de Hoy"),
                Column(
                  children: widgets,
                ),
              ],
            );
          } else {
            return Text('Cargando medicación');
          }
        },
    );
  }
}