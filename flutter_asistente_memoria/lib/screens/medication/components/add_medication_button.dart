import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/screens/add_medication/add_medication.dart';

class AddMedicationButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60.0,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: StadiumBorder(),
        ),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddMedication()));
        },
        child: Text("Añadir Medicación", style: TextStyle(fontSize: 25)),
      ),
    );
  }
}