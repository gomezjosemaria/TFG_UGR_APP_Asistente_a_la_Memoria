
import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/model/medication_model.dart';
import 'package:flutter_asistente_memoria/screens/edit_medication/edit_medication.dart';

class MedicationItem extends StatelessWidget {

  const MedicationItem({Key? key, required this.medicationModel, required this.activated}) : super(key: key);

  final MedicationModel medicationModel;
  final bool activated;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditMedication(medicationModel: medicationModel, activated: activated,)));
        },
        child: Container(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 10.0,
              ),
              Text(medicationModel.name, style: TextStyle(fontSize: 25)),
              SizedBox(
                width: double.infinity,
                height: 10.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}