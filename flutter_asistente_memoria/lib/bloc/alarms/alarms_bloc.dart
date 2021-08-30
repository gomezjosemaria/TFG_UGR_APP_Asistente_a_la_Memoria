import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_asistente_memoria/functions/alarm_manager.dart';
import 'package:flutter_asistente_memoria/functions/authentication.dart';
import 'package:flutter_asistente_memoria/model/alarm_model.dart';
import 'package:flutter_asistente_memoria/model/user.dart';

part 'alarms_event.dart';
part 'alarms_state.dart';

class AlarmsBloc extends Bloc<AlarmsEvent, AlarmsState> {
  AlarmsBloc() : super(AlarmsState());

  @override
  Stream<AlarmsState> mapEventToState(
    AlarmsEvent event,
  ) async* {
    if (event is AlarmsStarted) {
      yield state.copyWith(status: AlarmsStatus.alarmsLoading);
      try {
        if (Authentication.getUserRole() == UserRole.caregiver) {
          await AlarmManager.loadAlarms(Authentication.getUserBond());
        }
        else if (Authentication.getUserRole() == UserRole.careReceiver) {
          await AlarmManager.loadAlarms(Authentication.getCurrentUserEmail());
        }
        yield state.copyWith(status: AlarmsStatus.alarmsLoadedSuccessfully, alarmsActivated: AlarmManager.getAlarmsActive(), alarmsDeactivated: AlarmManager.getAlarmsDeactivate());
      } catch (e) {
        yield state.copyWith(status: AlarmsStatus.error);
      }
    }
  }
}
