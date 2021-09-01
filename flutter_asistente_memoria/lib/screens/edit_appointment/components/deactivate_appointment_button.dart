import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/bloc/edit_appointment/edit_appointment_bloc.dart';
import 'package:flutter_asistente_memoria/model/appointments_model.dart';
import 'package:flutter_asistente_memoria/screens/appointments/appointments.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeactivateAppointmentButton extends StatelessWidget {
  final AppointmentModel appointmentModel;
  final bool activated;

  const DeactivateAppointmentButton({Key? key, required this.appointmentModel, required this.activated}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditAppointmentBloc, EditAppointmentState>(
      listenWhen: (previous, current) =>
      previous is EditAppointmentDeactivateState && current is EditAppointmentDeactivateState && previous != current,
      listener: (context, state) {
        if (state is EditAppointmentDeactivateSuccessState) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => Appointments()));
        }
      },
      buildWhen: (previous, current) =>
      previous is EditAppointmentDeactivateState && current is EditAppointmentDeactivateState && previous != current,
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          height: 60.0,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: StadiumBorder(),
            ),
            onPressed: state is EditAppointmentDeletingState ? null : () {
              context.read<EditAppointmentBloc>().add(EditAppointmentDeactivate(appointmentModel, activated));
            },
            child: state is EditAppointmentDeactivatingState
                ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
                : activated ? Text("Desactivar") : Text("Activar"),
          ),
        );
      },
    );
  }
}