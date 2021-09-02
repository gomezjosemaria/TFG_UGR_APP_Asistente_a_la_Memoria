import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/bloc/planner/planner_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/body.dart';

class Planner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medicación'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: BlocProvider(
            create: (context) => PlannerBloc()..add(PlannerStarted()),
            child: Body(),
          ),
        ),
      ),
    );
  }
}