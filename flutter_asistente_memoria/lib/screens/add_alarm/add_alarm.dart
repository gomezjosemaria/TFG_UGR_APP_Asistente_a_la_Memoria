import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/bloc/add_alarm/add_alarm_bloc.dart';
import 'package:flutter_asistente_memoria/functions/to_string.dart';
import 'package:flutter_asistente_memoria/screens/alarms/alarms.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:weekday_selector/weekday_selector.dart';

class AddAlarm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Añadir Alarma'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: BlocProvider(
          create: (context) => AddAlarmBloc(),
          child: Align(
            alignment: Alignment.center,
            child: SafeArea(
              child: Column(
                children: [
                  _AlarmTitleInput(),
                  SizedBox(
                    width: double.infinity,
                    height: 10.0,
                  ),
                  _AlarmTimeInput(),
                  SizedBox(
                    width: double.infinity,
                    height: 10.0,
                  ),
                  _AlarmRepeat(),
                  SizedBox(
                    width: double.infinity,
                    height: 10.0,
                  ),
                  _AddAlarmButton()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AddAlarmButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddAlarmBloc, AddAlarmState>(
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
              context.read<AddAlarmBloc>().add(const AddAlarmSubmitted());
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

class _AlarmTitleInput extends StatelessWidget {
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
        BlocBuilder<AddAlarmBloc, AddAlarmState>(
          builder: (context, state) {
            return TextField(
              key: const Key('addAlarmForm_titleInput_textField'),
              onChanged: (titleInput) => context.read<AddAlarmBloc>().add(AddAlarmTitleChanged(titleInput)),
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

class _AlarmTimeInput extends StatelessWidget {
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
        BlocBuilder<AddAlarmBloc, AddAlarmState>(
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
                    context.read<AddAlarmBloc>().add(AddAlarmTimeChanged(selectedTime));
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

class _AlarmRepeat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddAlarmBloc, AddAlarmState>(
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
                      context.read<AddAlarmBloc>().add(AddAlarmRepeatChanged(value));
                    }
                  },
                ),
              ],
            ),
            if (state.repeat) WeekdaySelector(
              onChanged: (int day) {
                List<bool> auxRepeatWeekDays = List.from(state.repeatWeekDays);
                auxRepeatWeekDays[day % 7] = !auxRepeatWeekDays[day % 7];
                context.read<AddAlarmBloc>().add(AddAlarmRepeatWeekDaysChanged(auxRepeatWeekDays));
                print(day % 7);
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