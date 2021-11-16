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
              SizedBox(
                width: double.infinity,
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(appointmentModel.place, style: TextStyle(fontSize: 20)),
                  SizedBox(
                    width: 1,
                    height: 1,
                  ),
                ],
              ),
              SizedBox(
                width: double.infinity,
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(appointmentModel.date, style: TextStyle(fontSize: 25)),
                  SizedBox(
                    width: 20,
                    height: 20,
                  ),
                  Text(appointmentModel.time, style: TextStyle(fontSize: 25)),
                ],
              ),
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