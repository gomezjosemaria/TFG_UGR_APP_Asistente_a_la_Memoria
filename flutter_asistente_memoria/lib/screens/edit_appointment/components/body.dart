import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/model/appointments_model.dart';

import 'deactivate_appointment_button.dart';
import 'delete_appointment_button.dart';
import 'edit_appointment_form.dart';

class Body extends StatelessWidget {

  final AppointmentModel appointmentModel;
  final bool activated;

  const Body({Key? key, required this.appointmentModel, required this.activated}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SafeArea(
        child: Column(
          children: [
            EditAppointmentForm(appointmentModel: appointmentModel, activated: activated,),
            SizedBox(
              width: double.infinity,
              height: 20.0,
            ),
            DeleteAppointmentButton(appointmentModel: appointmentModel, activated: activated),
            SizedBox(
              width: double.infinity,
              height: 20.0,
            ),
            DeactivateAppointmentButton(appointmentModel: appointmentModel, activated: activated),
          ],
        ),
      ),
    );
  }
}