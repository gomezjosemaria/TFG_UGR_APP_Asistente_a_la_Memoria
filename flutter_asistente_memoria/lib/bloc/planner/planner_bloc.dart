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
        await PlannerManager.loadAll();
        yield state.copyWith(status: PlannerStatus.loadedSuccessfully);
      } catch (e) {
        yield state.copyWith(status: PlannerStatus.error);
      }
    }
  }
}
