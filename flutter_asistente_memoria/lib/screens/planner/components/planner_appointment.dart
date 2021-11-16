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
              SizedBox(
                width: double.infinity,
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(appointmentModel.place, style: TextStyle(fontSize: 20)),
                  Icon(
                    Icons.local_hospital,
                    size: 25,
                  ),
                ],
              ),
              Text(appointmentModel.time, style: TextStyle(fontSize: 25)),
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