import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_asistente_memoria/functions/authentication.dart';
import 'package:flutter_asistente_memoria/functions/planner_manager.dart';
import 'package:flutter_asistente_memoria/model/user.dart';

part 'planner_event.dart';
part 'planner_state.dart';

class PlannerBloc extends Bloc<PlannerEvent, PlannerState> {
  PlannerBloc() : super(PlannerState());

  @override
  Stream<PlannerState> mapEventToState(
    PlannerEvent event,
  ) async* {
    if (event is PlannerStarted) {
      yield state.copyWith(status: PlannerStatus.loading);
      try {
        if (Authentication.getUserRole() == UserRole.caregiver) {
          await PlannerManager.loadTodayAlarm(Authentication.getUserBond());
          await PlannerManager.loadTodayAppointments(Authentication.getUserBond());
          await PlannerManager.loadTodayMedication(Authentication.getUserBond());
        }
        else if (Authentication.getUserRole() == UserRole.careReceiver) {
          await PlannerManager.loadTodayAlarm(Authentication.getCurrentUserEmail());
          await PlannerManager.loadTodayAppointments(Authentication.getCurrentUserEmail());
          await PlannerManager.loadTodayMedication(Authentication.getCurrentUserEmail());
        }
        print('GET IT');
        PlannerManager.orderByTime();
        yield state.copyWith(status: PlannerStatus.loadedSuccessfully);
        print('DONE');
      } catch (e) {
        yield state.copyWith(status: PlannerStatus.error);
      }
    }
  }
}
