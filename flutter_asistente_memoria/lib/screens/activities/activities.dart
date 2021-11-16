import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/bloc/activities/activities_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/body.dart';

class Activities extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Actividades', style: TextStyle(fontSize: 25)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: BlocProvider(
            create: (context) => ActivitiesBloc()..add(ActivitiesStarted()),
            child: Body(),
          ),
        ),
      ),
    );
  }
}
