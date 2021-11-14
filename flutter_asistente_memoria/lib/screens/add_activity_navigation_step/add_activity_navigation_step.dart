import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/bloc/add_activity/add_activity_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/body.dart';

class AddActivityNavigationStep extends StatelessWidget {
  final bool next;

  const AddActivityNavigationStep({Key? key, required this.next})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (next) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Añadir Actividad'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: BlocProvider.value(
              value: BlocProvider.of<AddActivityBloc>(context)
                ..add(AddActivityNextStep()),
              child: Body(),
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Añadir Actividad'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: BlocProvider.value(
              value: BlocProvider.of<AddActivityBloc>(context)
                ..add(AddActivityPreviousStep()),
              child: Body(),
            ),
          ),
        ),
      );
    }
  }
}