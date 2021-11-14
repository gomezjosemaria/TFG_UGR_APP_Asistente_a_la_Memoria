import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_asistente_memoria/functions/activity_manager.dart';
import 'package:flutter_asistente_memoria/functions/authentication.dart';
import 'package:flutter_asistente_memoria/model/activity_model.dart';
import 'package:flutter_asistente_memoria/model/user.dart';

part 'activities_event.dart';
part 'activities_state.dart';

class ActivitiesBloc extends Bloc<ActivitiesEvent, ActivitiesState> {
  ActivitiesBloc() : super(ActivitiesState());

  @override
  Stream<ActivitiesState> mapEventToState(
      ActivitiesEvent event,
      ) async* {
    if (event is ActivitiesStarted) {
      yield state.copyWith(status: ActivitiesStatus.activitiesLoading);
      try {
        if (Authentication.getUserRole() == UserRole.caregiver) {
          await ActivityManager.loadActivities(Authentication.getUserBond());
        }
        else if (Authentication.getUserRole() == UserRole.careReceiver) {
          await ActivityManager.loadActivities(Authentication.getCurrentUserEmail());
        }
        yield state.copyWith(status: ActivitiesStatus.activitiesLoadedSuccessfully, activities: ActivityManager.getActivities());
      } catch (e) {
        yield state.copyWith(status: ActivitiesStatus.error);
      }
    }
  }
}
