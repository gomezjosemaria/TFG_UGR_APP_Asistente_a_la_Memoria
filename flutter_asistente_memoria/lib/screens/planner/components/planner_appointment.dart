import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/model/appointments_model.dart';

class PlannerAppointment extends StatelessWidget {

  const PlannerAppointment({Key? key, required this.appointmentModel, required this.activated}) : super(key: key);

  final AppointmentModel appointmentModel;
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(appointmentModel.date),
                  Switch(value: activated, onChanged: null),
                ],
              ),
              Text(appointmentModel.place),
            ],
          ),
        ),
      ),
    );
  }
}