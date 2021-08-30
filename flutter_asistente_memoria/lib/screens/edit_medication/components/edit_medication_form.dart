import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/bloc/edit_medication/edit_medication_bloc.dart';
import 'package:flutter_asistente_memoria/functions/medication_manager.dart';
import 'package:flutter_asistente_memoria/model/medication_model.dart';
import 'package:flutter_asistente_memoria/screens/medication/medication.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weekday_selector/weekday_selector.dart';
import 'package:formz/formz.dart';
import 'package:flutter_asistente_memoria/functions/to_string.dart';

class EditMedicationForm extends StatelessWidget {

  final MedicationModel medicationModel;
  final bool activated;

  const EditMedicationForm({Key? key, required this.medicationModel, required this.activated}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _MedicationNameInput(initialValue: medicationModel.name,),
        SizedBox(
          width: double.infinity,
          height: 10.0,
        ),
        _MedicationTimeInput(),
        SizedBox(
          width: double.infinity,
          height: 10.0,
        ),
        _MedicationFrequency(),
        SizedBox(
          width: double.infinity,
          height: 10.0,
        ),
        _MedicationFrequencyNumber(),
        SizedBox(
          width: double.infinity,
          height: 10.0,
        ),
        _EditMedicationButton(medicationModel: medicationModel, activated: activated,)
      ],
    );
  }
}

class _MedicationFrequencyNumber extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditMedicationBloc, EditMedicationState>(
        buildWhen: (previous, current) =>
        previous.frequency != current.frequency || previous.frequencyNumber != current.frequencyNumber || previous.repeatWeekDays != current.repeatWeekDays,
        builder: (context, state) {
          print(state);
          if (state.frequency == MedicationManager.getFrequencyOptions()[1] ||
              state.frequency == MedicationManager.getFrequencyOptions()[2]) {
            List<String> options = <String>[];
            String text = '';
            if (state.frequency == MedicationManager.getFrequencyOptions()[1]) {
              options = MedicationManager.getEveryXHourOptions();
              text = 'Horas';
            } else if (state.frequency ==
                MedicationManager.getFrequencyOptions()[2]) {
              options = MedicationManager.getEveryXDayOptions();
              text = 'Días';
            }
            return Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    text,
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 10.0,
                ),
                DropdownButtonFormField<String>(
                  value: state.frequencyNumber,
                  isExpanded: true,
                  icon: const Icon(Icons.arrow_downward),
                  items: options.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value.toString()),
                    );
                  }).toList(),
                  onChanged: (value) => context
                      .read<EditMedicationBloc>()
                      .add(EditMedicationFrequencyNumberChanged(value!)),
                ),
              ],
            );
          } else if (state.frequency ==
              MedicationManager.getFrequencyOptions()[3]) {
            return Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Días de la semana',
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 10.0,
                ),
                WeekdaySelector(
                  onChanged: (int day) {
                    List<bool> auxRepeatWeekDays =
                    List.from(state.repeatWeekDays);
                    auxRepeatWeekDays[day % 7] = !auxRepeatWeekDays[day % 7];
                    context.read<EditMedicationBloc>().add(EditMedicationRepeatWeekDaysChanged(auxRepeatWeekDays));
                  },
                  values: state.repeatWeekDays,
                  shortWeekdays: ['L', 'M', 'X', 'J', 'V', 'S', 'D'],
                  firstDayOfWeek: 0,
                ),
              ],
            );
          } else {
            return SizedBox(
              width: double.infinity,
              height: 10.0,
            );
          }
        });
  }
}

class _MedicationFrequency extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Frecuencia',
            textAlign: TextAlign.left,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        BlocBuilder<EditMedicationBloc, EditMedicationState>(
            builder: (context, state) {
              return DropdownButtonFormField<String>(
                value: state.frequency,
                isExpanded: true,
                icon: const Icon(Icons.arrow_downward),
                items: MedicationManager.getFrequencyOptions()
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) => context
                    .read<EditMedicationBloc>()
                    .add(EditMedicationFrequencyChanged(value!)),
              );
            }),
      ],
    );
  }
}

class _EditMedicationButton extends StatelessWidget {

  final MedicationModel medicationModel;
  final bool activated;

  const _EditMedicationButton({Key? key, required this.medicationModel, required this.activated}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditMedicationBloc, EditMedicationState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Medication()));
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
                  .read<EditMedicationBloc>()
                  .add(EditMedicationSubmitted(medicationModel, activated));
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

class _MedicationTimeInput extends StatelessWidget {
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
        BlocBuilder<EditMedicationBloc, EditMedicationState>(
            buildWhen: (previous, current) =>
            previous.timeInput != current.timeInput,
            builder: (context, state) {
              return SizedBox(
                width: double.infinity,
                height: 80.0,
                child: ElevatedButton(
                  key: const Key('addMedicationForm_timeInput_elevatedButton'),
                  onPressed: () async {
                    var selectedTime = await showTimePicker(
                      context: context,
                      initialTime: state.timeInput,
                    );

                    if (selectedTime != null &&
                        selectedTime != state.timeInput) {
                      context
                          .read<EditMedicationBloc>()
                          .add(EditMedicationTimeChanged(selectedTime));
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

class _MedicationNameInput extends StatelessWidget {

  final String initialValue;

  const _MedicationNameInput({Key? key, required this.initialValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Título',
            textAlign: TextAlign.left,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        BlocBuilder<EditMedicationBloc, EditMedicationState>(
            builder: (context, state) {
              TextEditingController _controller = TextEditingController();
              _controller.value = TextEditingValue(text: state.nameInput.value);
              var cursorPos = _controller.selection;
              if (cursorPos.start > _controller.text.length) {
                cursorPos = TextSelection.fromPosition(TextPosition(offset: _controller.text.length));
              }
              _controller.selection = cursorPos;
              return TextField(
                key: const Key('editMedicationForm_nameInput_textField'),
                onChanged: (nameInput) => context
                    .read<EditMedicationBloc>()
                    .add(EditMedicationNameChanged(nameInput)),
                controller: new TextEditingController.fromValue(new TextEditingValue(text: state.nameInput.value,selection: new TextSelection.collapsed(offset: state.nameInput.value.length))),
                decoration: InputDecoration(
                  border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
                  prefixIcon: Icon(
                    Icons.email,
                  ),
                  hintText: "Introduce el nombre del Medicamento",
                ),
              );
            }),
      ],
    );
  }
}