import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/bloc/alarms/alarms_bloc.dart';
import 'package:flutter_asistente_memoria/screens/alarms/components/body.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Alarms extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alarmas'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: BlocProvider(
            create: (context) => AlarmsBloc()..add(AlarmsStarted()),
            child: Body(),
          ),
        ),
      ),
    );
  }
}