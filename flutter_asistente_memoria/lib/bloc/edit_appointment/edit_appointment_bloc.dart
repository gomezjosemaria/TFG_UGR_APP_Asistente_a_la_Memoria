import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/functions/appointment_manager.dart';
import 'package:flutter_asistente_memoria/functions/authentication.dart';
import 'package:flutter_asistente_memoria/functions/to_string.dart';
import 'package:flutter_asistente_memoria/model/appointments_model.dart';
import 'package:flutter_asistente_memoria/model/name_input.dart';
import 'package:flutter_asistente_memoria/model/user.dart';
import 'package:formz/formz.dart';

part 'edit_appointment_event.dart';
part 'edit_appointment_state.dart';

class EditAppointmentBloc extends Bloc<EditAppointmentEvent, EditAppointmentState> {
  EditAppointmentBloc() : super(EditAppointmentState());

  @override
  Stream<EditAppointmentState> mapEventToState(
    EditAppointmentEvent event,
  ) async* {
    if (event is EditAppointmentStarted) {
      yield _mapEditAppointmentStartedToState(event, state);
    }
    else if (event is EditAppointmentPlaceChanged) {
      yield _mapEditAppointmentPlaceChangedToState(event, state);
    }
    else if (event is EditAppointmentDateChanged) {
      yield _mapEditAppointmentDateChangedToState(event, state);
    }
    else if (event is EditAppointmentTimeChanged) {
      yield _mapEditAppointmentTimeChangedToState(event, state);
    }
    else if (event is EditAppointmentSubmitted) {
      yield* _mapEditAppointmentSubmittedToState(event, state);
    }
    else if (event is EditAppointmentDelete) {
      yield* _mapEditAppointmentDeleteToState(event, state);
    }
    else if (event is EditAppointmentDeactivate) {
      yield* _mapEditAppointmentDeactivateToState(event, state);
    }
  }

  EditAppointmentState _mapEditAppointmentStartedToState(EditAppointmentStarted event, EditAppointmentState state) {
    return state.copyWith(
      status: Formz.validate([NameInput.dirty(event.appointment.place)]),
      placeInput: NameInput.dirty(event.appointment.place),
      dateInput: DateTime.parse(event.appointment.date),
      timeInput: ToString.stringToTimeOfDay(event.appointment.time),
      active: event.activated,
    );
  }

  EditAppointmentState _mapEditAppointmentPlaceChangedToState(EditAppointmentPlaceChanged event, EditAppointmentState state) {
    final placeInput = NameInput.dirty(event.placeInput);
    return state.copyWith(
      placeInput: placeInput,
      status: Formz.validate([placeInput]),
    );
  }

  EditAppointmentState _mapEditAppointmentDateChangedToState(EditAppointmentDateChanged event, EditAppointmentState state) {
    final dateInput = event.dateInput;
    return state.copyWith(
      dateInput: dateInput,
    );
  }

  EditAppointmentState _mapEditAppointmentTimeChangedToState(EditAppointmentTimeChanged event, EditAppointmentState state) {
    final timeInput = event.timeInput;
    return state.copyWith(
      timeInput: timeInput,
    );
  }

  Stream<EditAppointmentState> _mapEditAppointmentSubmittedToState(EditAppointmentSubmitted event, EditAppointmentState state) async* {
    final FormzStatus status = Formz.validate([state.placeInput]);
    final AppointmentModel appointment = new AppointmentModel(
      state.placeInput.value,
      state.dateInput.toString().substring(0,10),
      ToString.timeOfDayToString(state.timeInput),
    );
    if (status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      try {
        if (Authentication.getUserRole() == UserRole.caregiver) {
          await AppointmentManager.deleteAppointment(event.appointmentUnmodified, Authentication.getUserBond(), event.activateUnmodified);
          await AppointmentManager.saveAppointment(appointment, Authentication.getUserBond(), true);
        }
        else {
          await AppointmentManager.deleteAppointment(event.appointmentUnmodified, Authentication.getCurrentUser().email, event.activateUnmodified);
          await AppointmentManager.saveAppointment(appointment, Authentication.getCurrentUser().email, true);
        }
        yield state.copyWith(status: FormzStatus.submissionSuccess);
      } on Exception {
        yield state.copyWith(status: FormzStatus.submissionFailure);
      }
    }
    else {
      yield state.copyWith(
        status: FormzStatus.invalid,
      );
    }
  }

  Stream<EditAppointmentState> _mapEditAppointmentDeleteToState(EditAppointmentDelete event, EditAppointmentState state) async* {
    var userEmail;
    yield EditAppointmentDeletingState();
    if (Authentication.getUserRole() == UserRole.caregiver) {
      userEmail = Authentication.getUserBond();
    }
    else {
      userEmail = Authentication.getCurrentUser().email;
    }
    try {
      await AppointmentManager.deleteAppointment(event.appointmentUnmodified, userEmail, event.activateUnmodified);
    } on Exception {
      yield EditAppointmentDeleteErrorState();
    }
    yield EditAppointmentDeleteSuccessState();
  }

  Stream<EditAppointmentState> _mapEditAppointmentDeactivateToState(EditAppointmentDeactivate event, EditAppointmentState state) async* {
    var userEmail;
    yield EditAppointmentDeactivatingState();
    if (Authentication.getUserRole() == UserRole.caregiver) {
      userEmail = Authentication.getUserBond();
    }
    else {
      userEmail = Authentication.getCurrentUser().email;
    }
    try {
      await AppointmentManager.deleteAppointment(event.appointmentUnmodified, userEmail, event.activateUnmodified);
      await AppointmentManager.saveAppointment(event.appointmentUnmodified, userEmail, !event.activateUnmodified);
    } on Exception {
      yield EditAppointmentDeactivateErrorState();
    }
    yield EditAppointmentDeactivateSuccessState();
  }
}
