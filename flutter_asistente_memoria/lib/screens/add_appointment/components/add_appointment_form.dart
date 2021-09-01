import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/bloc/add_appointment/add_appointment_bloc.dart';
import 'package:flutter_asistente_memoria/functions/to_string.dart';
import 'package:flutter_asistente_memoria/screens/appointments/appointments.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class AddAppointmentForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _AppointmentPlaceInput(),
        SizedBox(
          width: double.infinity,
          height: 10.0,
        ),
        _AppointmentDateInput(),
        SizedBox(
          width: double.infinity,
          height: 10.0,
        ),
        _AppointmentTimeInput(),
        SizedBox(
          width: double.infinity,
          height: 10.0,
        ),
        _AddAppointmentButton(),
      ],
    );
  }
}

class _AppointmentPlaceInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Lugar',
            textAlign: TextAlign.left,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        BlocBuilder<AddAppointmentBloc, AddAppointmentState>(
            builder: (context, state) {
          return TextField(
            key: const Key('addAppointmentForm_placeInput_textField'),
            onChanged: (placeInput) => context
                .read<AddAppointmentBloc>()
                .add(AddAppointmentPlaceChanged(placeInput)),
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
              prefixIcon: Icon(
                Icons.place,
              ),
              hintText: "Introduce el lugar de la cita",
            ),
          );
        }),
      ],
    );
  }
}

class _AppointmentDateInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Fecha',
            textAlign: TextAlign.left,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        BlocBuilder<AddAppointmentBloc, AddAppointmentState>(
            buildWhen: (previous, current) =>
                previous.dateInput != current.dateInput,
            builder: (context, state) {
              return SizedBox(
                width: double.infinity,
                height: 80.0,
                child: ElevatedButton(
                  key: const Key('addAppointmentForm_dateInput_elevatedButton'),
                  onPressed: () async {
                    var selectedDate = await showDatePicker(
                      context: context,
                      lastDate: DateTime(2101),
                      firstDate: DateTime.now().add(const Duration(days: 1)),
                      initialDate: state.dateInput,
                    );

                    if (selectedDate != null &&
                        selectedDate != state.dateInput) {
                      context
                          .read<AddAppointmentBloc>()
                          .add(AddAppointmentDateChanged(selectedDate));
                    }
                  },
                  child: Text(
                    "${state.dateInput.day}/${state.dateInput.month}/${state.dateInput.year}",
                    style: TextStyle(fontSize: 40),
                  ),
                ),
              );
            }),
      ],
    );
  }
}

class _AppointmentTimeInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Hora',
            textAlign: TextAlign.left,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        BlocBuilder<AddAppointmentBloc, AddAppointmentState>(
            buildWhen: (previous, current) =>
                previous.timeInput != current.timeInput,
            builder: (context, state) {
              return SizedBox(
                width: double.infinity,
                height: 80.0,
                child: ElevatedButton(
                  key: const Key('addAppointmentForm_timeInput_elevatedButton'),
                  onPressed: () async {
                    var selectedTime = await showTimePicker(
                      context: context,
                      initialTime: state.timeInput,
                    );

                    if (selectedTime != null &&
                        selectedTime != state.timeInput) {
                      context
                          .read<AddAppointmentBloc>()
                          .add(AddAppointmentTimeChanged(selectedTime));
                    }
                  },
                  child: Text(
                    ToString.timeOfDayToString(state.timeInput),
                    style: TextStyle(fontSize: 40),
                  ),
                ),
              );
            }),
      ],
    );
  }
}

class _AddAppointmentButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddAppointmentBloc, AddAppointmentState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Appointments()));
        }
      },
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          height: 60.0,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: StadiumBorder(),
            ),
            onPressed: state.status.isSubmissionInProgress
                ? null
                : () {
                    context
                        .read<AddAppointmentBloc>()
                        .add(const AddAppointmentSubmitted());
                  },
            child: state.status.isSubmissionInProgress
                ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
                : Text("Guardar"),
          ),
        );
      },
    );
  }
}
