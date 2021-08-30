import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/screens/medication/components/medication_list.dart';

import 'add_medication_button.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SafeArea(
        child: Column(
          children: [
            AddMedicationButton(),
            MedicationList(),
          ],
        ),
      ),
    );
  }
}