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

part 'add_appointment_event.dart';
part 'add_appointment_state.dart';

class AddAppointmentBloc extends Bloc<AddAppointmentEvent, AddAppointmentState> {
  AddAppointmentBloc() : super(AddAppointmentState());

  @override
  Stream<AddAppointmentState> mapEventToState(
    AddAppointmentEvent event,
  ) async* {
    if (event is AddAppointmentPlaceChanged) {
      yield _mapAddAppointmentPlaceChangedToState(event, state);
    }
    else if (event is AddAppointmentDateChanged) {
      yield _mapAddAppointmentDateChangedToState(event, state);
    }
    else if (event is AddAppointmentTimeChanged) {
      yield _mapAddAppointmentTimeChangedToState(event, state);
    }
    else if (event is AddAppointmentSubmitted) {
      yield* _mapAddAppointmentSubmittedToState(event, state);
    }
  }

  AddAppointmentState _mapAddAppointmentPlaceChangedToState(AddAppointmentPlaceChanged event, AddAppointmentState state) {
    final placeInput = NameInput.dirty(event.placeInput);
    return state.copyWith(
      placeInput: placeInput,
      status: Formz.validate([placeInput]),
    );
  }

  AddAppointmentState _mapAddAppointmentDateChangedToState(AddAppointmentDateChanged event, AddAppointmentState state) {
    final dateInput = event.dateInput;
    return state.copyWith(
      dateInput: dateInput,
    );
  }

  AddAppointmentState _mapAddAppointmentTimeChangedToState(AddAppointmentTimeChanged event, AddAppointmentState state) {
    final timeInput = event.timeInput;
    return state.copyWith(
      timeInput: timeInput,
    );
  }

  Stream<AddAppointmentState> _mapAddAppointmentSubmittedToState(AddAppointmentSubmitted event, AddAppointmentState state) async* {
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
          await AppointmentManager.saveAppointment(appointment, Authentication.getUserBond(), true);
        }
        else {
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
        placeInput: state.placeInput,
        dateInput: state.dateInput,
        timeInput: state.timeInput,
      );
    }
  }




}
