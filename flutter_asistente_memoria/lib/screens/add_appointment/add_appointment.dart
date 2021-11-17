import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/bloc/add_appointment/add_appointment_bloc.dart';
import 'package:flutter_asistente_memoria/screens/appointments/appointments.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/body.dart';

class AddAppointment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Añadir Cita', style: TextStyle(fontSize: 25)),
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
            create: (context) => AddAppointmentBloc(),
            child: Body(),
          ),
        ),
      ),
    );
  }
}
