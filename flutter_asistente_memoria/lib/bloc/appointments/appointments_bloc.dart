import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_asistente_memoria/functions/appointment_manager.dart';
import 'package:flutter_asistente_memoria/functions/authentication.dart';
import 'package:flutter_asistente_memoria/model/appointments_model.dart';
import 'package:flutter_asistente_memoria/model/user.dart';

part 'appointments_event.dart';
part 'appointments_state.dart';

class AppointmentsBloc extends Bloc<AppointmentsEvent, AppointmentsState> {
  AppointmentsBloc() : super(AppointmentsState());

  @override
  Stream<AppointmentsState> mapEventToState(
    AppointmentsEvent event,
  ) async* {
    if (event is AppointmentsStarted) {
      yield state.copyWith(status: AppointmentsStatus.appointmentsLoading);
      try {
        if (Authentication.getUserRole() == UserRole.caregiver) {
          await AppointmentManager.loadAppointments(Authentication.getUserBond());
        }
        else if (Authentication.getUserRole() == UserRole.careReceiver) {
          await AppointmentManager.loadAppointments(Authentication.getCurrentUserEmail());
        }
        yield state.copyWith(status: AppointmentsStatus.appointmentsLoadedSuccessfully, appointmentsActivated: AppointmentManager.getAppointmentsActive(), appointmentsDeactivated: AppointmentManager.getAppointmentsDeactivate());
      } catch (e) {
        yield state.copyWith(status: AppointmentsStatus.error);
      }
    }
  }
}
