import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/bloc/appointments/appointments_bloc.dart';
import 'package:flutter_asistente_memoria/screens/main_menu/main_menu.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/body.dart';

class Appointments extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Citas Médicas', style: TextStyle(fontSize: 25)),
        leading:
        IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => MainMenu()));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: BlocProvider(
            create: (context) => AppointmentsBloc()..add(AppointmentsStarted()),
            child: Body(),
          ),
        ),
      ),
    );
  }
}