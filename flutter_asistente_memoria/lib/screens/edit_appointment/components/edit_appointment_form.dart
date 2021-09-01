import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/bloc/edit_appointment/edit_appointment_bloc.dart';
import 'package:flutter_asistente_memoria/functions/to_string.dart';
import 'package:flutter_asistente_memoria/model/appointments_model.dart';
import 'package:flutter_asistente_memoria/screens/appointments/appointments.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';


class EditAppointmentForm extends StatelessWidget {

  final AppointmentModel appointmentModel;
  final bool activated;

  const EditAppointmentForm({Key? key, required this.appointmentModel, required this.activated}) : super(key: key);

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
        _EditAppointmentButton(appointmentModel: appointmentModel, activated: activated,),
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
        BlocBuilder<EditAppointmentBloc, EditAppointmentState>(
            builder: (context, state) {
              print(state.placeInput.value);
              TextEditingController _controller = TextEditingController();
              _controller.value = TextEditingValue(text: state.placeInput.value);
              var cursorPos = _controller.selection;
              if (cursorPos.start > _controller.text.length) {
                cursorPos = TextSelection.fromPosition(TextPosition(offset: _controller.text.length));
              }
              _controller.selection = cursorPos;
              return TextField(
                key: const Key('editAppointmentForm_placeInput_textField'),
                onChanged: (placeInput) => context
                    .read<EditAppointmentBloc>()
                    .add(EditAppointmentPlaceChanged(placeInput)),
                controller: new TextEditingController.fromValue(new TextEditingValue(text: state.placeInput.value,selection: new TextSelection.collapsed(offset: state.placeInput.value.length))),
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
        BlocBuilder<EditAppointmentBloc, EditAppointmentState>(
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
                          .read<EditAppointmentBloc>()
                          .add(EditAppointmentDateChanged(selectedDate));
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
        BlocBuilder<EditAppointmentBloc, EditAppointmentState>(
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
                          .read<EditAppointmentBloc>()
                          .add(EditAppointmentTimeChanged(selectedTime));
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

class _EditAppointmentButton extends StatelessWidget {
  final AppointmentModel appointmentModel;
  final bool activated;

  const _EditAppointmentButton({Key? key, required this.appointmentModel, required this.activated}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditAppointmentBloc, EditAppointmentState>(
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
              context.read<EditAppointmentBloc>().add(EditAppointmentSubmitted(appointmentModel, activated));
            },
            child: state.status.isSubmissionInProgress
                ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
                : Text("Guardar cambios"),
          ),
        );
      },
    );
  }
}
