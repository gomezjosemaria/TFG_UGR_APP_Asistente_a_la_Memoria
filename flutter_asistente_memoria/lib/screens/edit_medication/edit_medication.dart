import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/bloc/edit_medication/edit_medication_bloc.dart';
import 'package:flutter_asistente_memoria/model/medication_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/body.dart';

class EditMedication extends StatelessWidget {

  final MedicationModel medicationModel;
  final bool activated;

  const EditMedication({Key? key, required this.medicationModel, required this.activated}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Medicación', style: TextStyle(fontSize: 25)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: BlocProvider(
            create: (context) => EditMedicationBloc()..add(EditMedicationStarted(medicationModel, activated)),
            child: Body(medicationModel: medicationModel, activated: activated,),
          ),
        ),
      ),
    );
  }
}