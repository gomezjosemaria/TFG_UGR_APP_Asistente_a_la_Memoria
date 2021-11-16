import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/bloc/appointments/appointments_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'appointment.dart';

class AppointmentList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentsBloc, AppointmentsState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        if (state.status == AppointmentsStatus.appointmentsLoadedSuccessfully) {
          var listActivated = <Widget>[];
          var listDeactivated = <Widget>[];

          state.appointmentsActivated.forEach((i) {
            Appointment appointment = new Appointment(appointmentModel: i, activated: true);
            listActivated.add(appointment);
            listActivated.add(new SizedBox(height: 10,));
          });

          state.appointmentsDeactivated.forEach((i) {
            Appointment appointment = new Appointment(appointmentModel: i, activated: false);
            listDeactivated.add(appointment);
            listDeactivated.add(new SizedBox(height: 10,));
          });

          return Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 10.0,
              ),
              Text("Activas", style: TextStyle(fontSize: 25)),
              SizedBox(
                width: double.infinity,
                height: 10.0,
              ),
              Column(
                children: listActivated,
              ),
              SizedBox(
                width: double.infinity,
                height: 10.0,
              ),
              Text("Desactivadas", style: TextStyle(fontSize: 25)),
              SizedBox(
                width: double.infinity,
                height: 10.0,
              ),
              Column(
                children: listDeactivated,
              ),
            ],
          );
        } else {
          return Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 10.0,
              ),
              Text('Cargando citas...', style: TextStyle(fontSize: 25)),
            ],
          );
        }
      },
    );
  }
}