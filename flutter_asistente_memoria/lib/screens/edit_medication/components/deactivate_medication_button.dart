import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/bloc/edit_medication/edit_medication_bloc.dart';
import 'package:flutter_asistente_memoria/model/medication_model.dart';
import 'package:flutter_asistente_memoria/screens/medication/medication.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeactivateMedicationButton extends StatelessWidget {
  final MedicationModel medicationModel;
  final bool activated;

  const DeactivateMedicationButton({Key? key, required this.medicationModel, required this.activated}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditMedicationBloc, EditMedicationState>(
      listenWhen: (previous, current) =>
      previous is EditMedicationDeactivateState && current is EditMedicationDeactivateState && previous != current,
      listener: (context, state) {
        if (state is EditMedicationDeactivateSuccessState) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => Medication()));
        }
      },
      buildWhen: (previous, current) =>
      previous is EditMedicationDeactivateState && current is EditMedicationDeactivateState && previous != current,
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          height: 60.0,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: StadiumBorder(),
            ),
            onPressed: state is EditMedicationDeletingState ? null : () {
              context.read<EditMedicationBloc>().add(EditMedicationDeactivate(medicationModel, activated));
            },
            child: state is EditMedicationDeactivatingState
                ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
                : activated ? Text("Desactivar") : Text("Activar"),
          ),
        );
      },
    );
  }
}