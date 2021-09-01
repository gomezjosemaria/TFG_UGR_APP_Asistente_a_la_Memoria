import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/model/appointments_model.dart';
import 'package:flutter_asistente_memoria/screens/edit_appointment/edit_appointment.dart';

class Appointment extends StatelessWidget {

  const Appointment({Key? key, required this.appointmentModel, required this.activated}) : super(key: key);

  final AppointmentModel appointmentModel;
  final bool activated;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditAppointment(appointmentModel: appointmentModel, activated: activated,)));
        },
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