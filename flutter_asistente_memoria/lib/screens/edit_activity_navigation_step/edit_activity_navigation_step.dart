import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/bloc/add_activity/add_activity_bloc.dart';
import 'package:flutter_asistente_memoria/screens/activities/activities.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/body.dart';

class EditActivityNavigationStep extends StatelessWidget {
  final bool next;

  const EditActivityNavigationStep({Key? key, required this.next})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (next) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Editar Actividad', style: TextStyle(fontSize: 25)),
          leading:
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Activities()));
            },
          ),
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
          title: Text('Editar Actividad', style: TextStyle(fontSize: 25)),
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
