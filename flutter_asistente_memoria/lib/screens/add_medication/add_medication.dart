import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/bloc/add_medication/add_medication_bloc.dart';
import 'package:flutter_asistente_memoria/screens/medication/medication.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/body.dart';

class AddMedication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Añadir Medicación', style: TextStyle(fontSize: 25)),
        leading:
        IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Medication()));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: BlocProvider(
            create: (context) => AddMedicationBloc(),
            child: Body(),
          ),
        ),
      ),
    );
  }
}