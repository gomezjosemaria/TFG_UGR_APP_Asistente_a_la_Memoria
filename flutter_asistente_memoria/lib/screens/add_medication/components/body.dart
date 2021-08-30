import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/screens/add_medication/components/add_medication_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SafeArea(
        child: Column(
          children: [
            AddMedicationForm(),
          ],
        ),
      ),
    );
  }
}