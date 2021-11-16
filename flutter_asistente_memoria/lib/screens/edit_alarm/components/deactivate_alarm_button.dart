import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/bloc/edit_alarm/edit_alarm_bloc.dart';
import 'package:flutter_asistente_memoria/model/alarm_model.dart';
import 'package:flutter_asistente_memoria/screens/alarms/alarms.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeactivateAlarmButton extends StatelessWidget {
  final AlarmModel alarmModel;
  final bool activated;

  const DeactivateAlarmButton({Key? key, required this.alarmModel, required this.activated}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditAlarmBloc, EditAlarmState>(
      listenWhen: (previous, current) =>
      previous is EditAlarmDeactivateState && current is EditAlarmDeactivateState && previous != current,
      listener: (context, state) {
        if (state is EditAlarmDeactivateSuccessState) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => Alarms()));
        }
      },
      buildWhen: (previous, current) =>
      previous is EditAlarmDeactivateState && current is EditAlarmDeactivateState && previous != current,
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          height: 60.0,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: StadiumBorder(),
            ),
            onPressed: state is EditAlarmDeletingState ? null : () {
              context.read<EditAlarmBloc>().add(EditAlarmDeactivate(alarmModel, activated));
            },
            child: state is EditAlarmDeactivatingState
                ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
                : activated ? Text("Desactivar", style: TextStyle(fontSize: 25)) : Text("Activar", style: TextStyle(fontSize: 25)),
          ),
        );
      },
    );
  }
}