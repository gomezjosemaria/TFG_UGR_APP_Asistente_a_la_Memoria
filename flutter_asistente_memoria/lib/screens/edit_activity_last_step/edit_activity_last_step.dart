import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/bloc/add_activity/add_activity_bloc.dart';
import 'package:flutter_asistente_memoria/screens/activities/activities.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/body.dart';

class EditActivityLastStep extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              ..add(AddActivityAddStep()),
            child: Body(),
          ),
        ),
      ),
    );
  }
}
