import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/bloc/edit_appointment/edit_appointment_bloc.dart';
import 'package:flutter_asistente_memoria/model/appointments_model.dart';
import 'package:flutter_asistente_memoria/screens/appointments/appointments.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/body.dart';

class EditAppointment extends StatelessWidget {

  final AppointmentModel appointmentModel;
  final bool activated;

  const EditAppointment({Key? key, required this.appointmentModel, required this.activated}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Cita', style: TextStyle(fontSize: 25)),
        leading:
        IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Appointments()));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: BlocProvider(
            create: (context) => EditAppointmentBloc()..add(EditAppointmentStarted(appointmentModel, activated)),
            child: Body(appointmentModel: appointmentModel, activated: activated,),
          ),
        ),
      ),
    );
  }
}