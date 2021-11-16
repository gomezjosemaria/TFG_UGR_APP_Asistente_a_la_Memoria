import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/model/medication_model.dart';

class PlannerMedication extends StatelessWidget {

  const PlannerMedication({Key? key, required this.medicationModel, required this.activated}) : super(key: key);

  final MedicationModel medicationModel;
  final bool activated;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        child: Container(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(medicationModel.name, style: TextStyle(fontSize: 20)),
                  Icon(
                    Icons.healing,
                    size: 25,
                  ),
                ],
              ),
              Text(medicationModel.time, style: TextStyle(fontSize: 25)),
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