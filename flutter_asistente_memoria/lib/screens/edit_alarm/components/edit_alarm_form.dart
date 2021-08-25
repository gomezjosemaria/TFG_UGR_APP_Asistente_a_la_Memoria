import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/bloc/edit_alarm/edit_alarm_bloc.dart';
import 'package:flutter_asistente_memoria/functions/to_string.dart';
import 'package:flutter_asistente_memoria/model/alarm.dart';
import 'package:flutter_asistente_memoria/screens/alarms/alarms.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weekday_selector/weekday_selector.dart';
import 'package:formz/formz.dart';

class EditAlarmForm extends StatelessWidget {

  final AlarmModel alarmModel;
  final bool activated;

  const EditAlarmForm({Key? key, required this.alarmModel, required this.activated}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _EditAlarmTitleInput(initialValue: alarmModel.tittle,),
        SizedBox(
          width: double.infinity,
          height: 10.0,
        ),
        _EditAlarmTimeInput(),
        SizedBox(
          width: double.infinity,
          height: 10.0,
        ),
        _EditAlarmRepeat(),
        SizedBox(
          width: double.infinity,
          height: 10.0,
        ),
        _EditAlarmButton(alarmModel: alarmModel, activated: activated,),
      ],
    );
  }
}

class _EditAlarmButton extends StatelessWidget {
  final AlarmModel alarmModel;
  final bool activated;

  const _EditAlarmButton({Key? key, required this.alarmModel, required this.activated}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditAlarmBloc, EditAlarmState>(
      listenWhen: (previous, current) =>
      previous.status != current.status,
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => Alarms()));
        }
      },
      buildWhen: (previous, current) =>
      previous.status != current.status,
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          height: 60.0,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: StadiumBorder(),
            ),
            onPressed: state.status.isSubmissionInProgress ? null : () {
              context.read<EditAlarmBloc>().add(EditAlarmSubmitted(alarmModel, activated));
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

class _EditAlarmRepeat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditAlarmBloc, EditAlarmState>(
        buildWhen: (previous, current) => previous.repeat != current.repeat || previous.repeatWeekDays != current.repeatWeekDays,
        builder: (context, state) {
          return Column(
            children: [
              Row(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Repetir',
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Checkbox(
                    value: state.repeat,
                    onChanged: (bool? value) {
                      if (value != null) {
                        context.read<EditAlarmBloc>().add(EditAlarmRepeatChanged(value));
                      }
                    },
                  ),
                ],
              ),
              if (state.repeat) WeekdaySelector(
                onChanged: (int day) {
                  List<bool> auxRepeatWeekDays = List.from(state.repeatWeekDays);
                  auxRepeatWeekDays[day % 7] = !auxRepeatWeekDays[day % 7];
                  context.read<EditAlarmBloc>().add(EditAlarmRepeatWeekDaysChanged(auxRepeatWeekDays));
                },
                values: state.repeatWeekDays,
                shortWeekdays: ['L', 'M', 'X', 'J', 'V', 'S', 'D'],
                firstDayOfWeek: 0,
              )
            ],
          );
        }
    );
  }
}

class _EditAlarmTimeInput extends StatelessWidget {
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
        BlocBuilder<EditAlarmBloc, EditAlarmState>(
            buildWhen: (previous, current) => previous.timeInput != current.timeInput,
            builder: (context, state) {
              return SizedBox(
                width: double.infinity,
                height: 80.0,
                child: ElevatedButton(
                  key: const Key('addAlarmForm_timeInput_elevatedButton'),
                  onPressed: () async {
                    var selectedTime = await showTimePicker(
                      context: context,
                      initialTime: state.timeInput,
                    );

                    if (selectedTime != null && selectedTime != state.timeInput) {
                      context.read<EditAlarmBloc>().add(EditAlarmTimeChanged(selectedTime));
                    }
                  },
                  child: Text(
                    ToString.timeOfDayToString(state.timeInput),
                    style: TextStyle(fontSize: 40),
                  ),
                ),
              );
            }
        ),
      ],
    );
  }
}

class _EditAlarmTitleInput extends StatelessWidget {
  final String initialValue;

  const _EditAlarmTitleInput({Key? key, required this.initialValue}) : super(key: key);

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
        BlocBuilder<EditAlarmBloc, EditAlarmState>(
            builder: (context, state) {
              TextEditingController _controller = TextEditingController();
              _controller.value = TextEditingValue(text: state.titleInput.value);
              var cursorPos = _controller.selection;
              if (cursorPos.start > _controller.text.length) {
                cursorPos = TextSelection.fromPosition(TextPosition(offset: _controller.text.length));
              }
              _controller.selection = cursorPos;
              return TextField(
                key: const Key('addAlarmForm_titleInput_textField'),
                onChanged: (titleInput) => context.read<EditAlarmBloc>().add(EditAlarmTitleChanged(titleInput)),
                controller: new TextEditingController.fromValue(new TextEditingValue(text: state.titleInput.value,selection: new TextSelection.collapsed(offset: state.titleInput.value.length))),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100)
                  ),
                  prefixIcon: Icon(
                    Icons.email,
                  ),
                  hintText: "Introduce un título para la Alarma",

                ),
              );
            }
        ),
      ],
    );
  }
}