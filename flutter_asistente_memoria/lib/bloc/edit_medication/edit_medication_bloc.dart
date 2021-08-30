import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/functions/authentication.dart';
import 'package:flutter_asistente_memoria/functions/medication_manager.dart';
import 'package:flutter_asistente_memoria/functions/to_string.dart';
import 'package:flutter_asistente_memoria/model/medication_model.dart';
import 'package:flutter_asistente_memoria/model/name_input.dart';
import 'package:flutter_asistente_memoria/model/user.dart';
import 'package:formz/formz.dart';

part 'edit_medication_event.dart';
part 'edit_medication_state.dart';

class EditMedicationBloc extends Bloc<EditMedicationEvent, EditMedicationState> {
  EditMedicationBloc() : super(EditMedicationState());

  @override
  Stream<EditMedicationState> mapEventToState(
    EditMedicationEvent event,
  ) async* {
    if (event is EditMedicationStarted) {
      yield _mapEditMedicationStartedToState(event, state);
    }
    else if (event is EditMedicationNameChanged) {
      yield _mapEditMedicationNameChangedToState(event, state);
    }
    else if (event is EditMedicationTimeChanged) {
      yield _mapEditMedicationTimeChangedToState(event, state);
    }
    else if (event is EditMedicationFrequencyChanged) {
      yield _mapEditMedicationFrequencyChangedToState(event, state);
    }
    else if (event is EditMedicationFrequencyNumberChanged) {
      yield _mapEditMedicationFrequencyNumberChangedToState(event, state);
    }
    else if (event is EditMedicationRepeatWeekDaysChanged) {
      yield _mapEditMedicationRepeatWeekDaysChangedToState(event, state);
    }
    else if (event is EditMedicationActiveChanged) {
      yield _mapEditMedicationActiveChangedToState(event, state);
    }
    else if (event is EditMedicationSubmitted) {
      yield* _mapEditMedicationSubmittedToState(event, state);
    }
    else if (event is EditMedicationDelete) {
      yield* _mapEditMedicationDeleteToState(event, state);
    }
    else if (event is EditMedicationDeactivate) {
      yield* _mapEditMedicationDeactivateToState(event, state);
    }
  }

  EditMedicationState _mapEditMedicationStartedToState(EditMedicationStarted event, EditMedicationState state) {
    return state.copyWith(
      status: Formz.validate([NameInput.dirty(event.medication.name)]),
      nameInput: NameInput.dirty(event.medication.name),
      timeInput: ToString.stringToTimeOfDay(event.medication.time),
      frequency: event.medication.frequency,
      frequencyNumber: event.medication.frequencyNumber.toString(),
      repeatWeekDays: event.medication.repeatWeekDays,
      active: event.activated,
    );
  }

  EditMedicationState _mapEditMedicationNameChangedToState(EditMedicationNameChanged event, EditMedicationState state) {
    final nameInput = NameInput.dirty(event.nameInput);
    return state.copyWith(
      nameInput: nameInput,
      status: Formz.validate([nameInput]),
    );
  }

  EditMedicationState _mapEditMedicationTimeChangedToState(EditMedicationTimeChanged event, EditMedicationState state) {
    final timeInput = event.timeInput;
    return state.copyWith(
      timeInput: timeInput,
      status: Formz.validate([state.nameInput]),
    );
  }

  EditMedicationState _mapEditMedicationFrequencyChangedToState(EditMedicationFrequencyChanged event, EditMedicationState state) {
    final frequency = event.frequency;
    var frequencyNumber = '0';
    if (frequency == MedicationManager.getFrequencyOptions()[1]) {
      frequencyNumber = MedicationManager.getEveryXHourOptions()[0];
    }
    else if (frequency == MedicationManager.getFrequencyOptions()[2]) {
      frequencyNumber = MedicationManager.getEveryXDayOptions()[0];
    }
    return state.copyWith(
      frequency: frequency,
      frequencyNumber: frequencyNumber,
      status: Formz.validate([state.nameInput]),
    );
  }

  EditMedicationState _mapEditMedicationFrequencyNumberChangedToState(EditMedicationFrequencyNumberChanged event, EditMedicationState state) {
    final frequencyNumber = event.frequencyNumber;
    return state.copyWith(
      frequencyNumber: frequencyNumber,
      status: Formz.validate([state.nameInput]),
    );
  }

  EditMedicationState _mapEditMedicationRepeatWeekDaysChangedToState(EditMedicationRepeatWeekDaysChanged event, EditMedicationState state) {
    final repeatWeekDays = event.repeatWeekDays;
    return state.copyWith(
      repeatWeekDays: repeatWeekDays,
      status: Formz.validate([state.nameInput]),
    );
  }

  EditMedicationState _mapEditMedicationActiveChangedToState(EditMedicationActiveChanged event, EditMedicationState state) {
    final active = event.active;
    return state.copyWith(
      active: active,
      status: Formz.validate([state.nameInput]),
    );
  }

  Stream<EditMedicationState> _mapEditMedicationSubmittedToState(EditMedicationSubmitted event, EditMedicationState state) async* {
    final FormzStatus status = Formz.validate([state.nameInput]);
    final MedicationModel medication = new MedicationModel(
      state.nameInput.value,
      ToString.timeOfDayToString(state.timeInput),
      state.frequency,
      double.parse(state.frequencyNumber),
      state.repeatWeekDays,
    );
    final String userEmail;

    if (status.isValidated) {

      yield state.copyWith(status: FormzStatus.submissionInProgress);

      if (Authentication.getUserRole() == UserRole.caregiver) {
        userEmail = Authentication.getUserBond();
      }
      else {
        userEmail = Authentication.getCurrentUser().email;
      }

      if (event.medicationUnmodified.name != state.nameInput.value || event.medicationUnmodified.time != ToString.timeOfDayToString(state.timeInput)) {
        try {
          await MedicationManager.deleteMedication(event.medicationUnmodified, userEmail, event.activateUnmodified);
        } on Exception {
          yield state.copyWith(status: FormzStatus.submissionFailure);
        }
      }

      try {
        await MedicationManager.saveMedication(medication, userEmail, state.active);
        yield state.copyWith(status: FormzStatus.submissionSuccess);
      } on Exception {
        yield state.copyWith(status: FormzStatus.submissionFailure);
      }
    }
    else {
      yield state.copyWith(
        status: FormzStatus.invalid,
        nameInput: state.nameInput,
        timeInput: state.timeInput,
        frequency: state.frequency,
        frequencyNumber: state.frequencyNumber,
        repeatWeekDays: state.repeatWeekDays,
      );
    }
  }

  Stream<EditMedicationState> _mapEditMedicationDeleteToState(EditMedicationDelete event, EditMedicationState state) async* {
    var userEmail;
    yield EditMedicationDeletingState();
    if (Authentication.getUserRole() == UserRole.caregiver) {
      userEmail = Authentication.getUserBond();
    }
    else {
      userEmail = Authentication.getCurrentUser().email;
    }
    try {
      await MedicationManager.deleteMedication(event.alarmUnmodified, userEmail, event.activateUnmodified);
    } on Exception {
      yield EditMedicationDeleteErrorState();
    }
    yield EditMedicationDeleteSuccessState();
  }

  Stream<EditMedicationState> _mapEditMedicationDeactivateToState(EditMedicationDeactivate event, EditMedicationState state) async* {
    var userEmail;
    yield EditMedicationDeactivatingState();
    if (Authentication.getUserRole() == UserRole.caregiver) {
      userEmail = Authentication.getUserBond();
    }
    else {
      userEmail = Authentication.getCurrentUser().email;
    }
    try {
      await MedicationManager.deleteMedication(event.alarmUnmodified, userEmail, event.activateUnmodified);
      await MedicationManager.saveMedication(event.alarmUnmodified, userEmail, !event.activateUnmodified);
    } on Exception {
      yield EditMedicationDeactivateErrorState();
    }
    yield EditMedicationDeactivateSuccessState();
  }
}
