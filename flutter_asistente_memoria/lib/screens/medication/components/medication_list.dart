import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/bloc/medication/medication_bloc.dart';
import 'package:flutter_asistente_memoria/screens/medication/components/medication_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MedicationList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MedicationBloc, MedicationState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        if (state.status == MedicationStatus.medicationLoadedSuccessfully) {
          var listActivated = <Widget>[];
          var listDeactivated = <Widget>[];

          state.medicationActivated.forEach((i) {
            MedicationItem medicationItem = new MedicationItem(medicationModel: i, activated: true);
            listActivated.add(medicationItem);
            listActivated.add(new SizedBox(height: 10,));
          });

          state.medicationDeactivated.forEach((i) {
            MedicationItem alarm = new MedicationItem(medicationModel: i, activated: false);
            listDeactivated.add(alarm);
            listDeactivated.add(new SizedBox(height: 10,));
          });

          return Column(
            children: [
              Text("Activa"),
              Column(
                children: listActivated,
              ),
              Text("Desactivada"),
              Column(
                children: listDeactivated,
              ),
            ],
          );
        } else {
          return Text('Cargando medicación');
        }
      },
    );
  }
}