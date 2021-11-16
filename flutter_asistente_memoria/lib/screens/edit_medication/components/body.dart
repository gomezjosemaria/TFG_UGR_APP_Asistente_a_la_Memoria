import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/model/medication_model.dart';

import 'deactivate_medication_button.dart';
import 'delete_medication_button.dart';
import 'edit_medication_form.dart';

class Body extends StatelessWidget {

  final MedicationModel medicationModel;
  final bool activated;

  const Body({Key? key, required this.medicationModel, required this.activated}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SafeArea(
        child: Column(
          children: [
            EditMedicationForm(medicationModel: medicationModel, activated: activated,),
            SizedBox(
              width: double.infinity,
              height: 20.0,
            ),
            DeleteMedicationButton(medicationModel: medicationModel, activated: activated),
            SizedBox(
              width: double.infinity,
              height: 20.0,
            ),
            DeactivateMedicationButton(medicationModel: medicationModel, activated: activated),
          ],
        ),
      ),
    );
  }
}