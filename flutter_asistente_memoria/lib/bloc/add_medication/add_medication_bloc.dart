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

part 'add_medication_event.dart';
part 'add_medication_state.dart';

class AddMedicationBloc extends Bloc<AddMedicationEvent, AddMedicationState> {
  AddMedicationBloc() : super(AddMedicationState());

  @override
  Stream<AddMedicationState> mapEventToState(
    AddMedicationEvent event,
  ) async* {
    if (event is AddMedicationNameChanged) {
      yield _mapAddMedicationNameChangedToState(event, state);
    }
    else if (event is AddMedicationTimeChanged) {
      yield _mapAddMedicationTimeChangedToState(event, state);
    }
    else if (event is AddMedicationFrequencyChanged) {
      yield _mapAddMedicationFrequencyChangedToState(event, state);
    }
    else if (event is AddMedicationFrequencyNumberChanged) {
      yield _mapAddMedicationFrequencyNumberChangedToState(event, state);
    }
    else if (event is AddMedicationRepeatWeekDaysChanged) {
      yield _mapAddMedicationRepeatWeekDaysChangedToState(event, state);
    }
    else if (event is AddMedicationSubmitted) {
      yield* _mapAddMedicationSubmittedToState(event, state);
    }
  }

  AddMedicationState _mapAddMedicationNameChangedToState(AddMedicationNameChanged event, AddMedicationState state) {
    final nameInput = NameInput.dirty(event.nameInput);
    return state.copyWith(
      nameInput: nameInput,
      status: Formz.validate([nameInput]),
    );
  }

  AddMedicationState _mapAddMedicationTimeChangedToState(AddMedicationTimeChanged event, AddMedicationState state) {
    final timeInput = event.timeInput;
    return state.copyWith(
      timeInput: timeInput,
      status: Formz.validate([state.nameInput]),
    );
  }

  AddMedicationState _mapAddMedicationFrequencyChangedToState(AddMedicationFrequencyChanged event, AddMedicationState state) {
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

  AddMedicationState _mapAddMedicationFrequencyNumberChangedToState(AddMedicationFrequencyNumberChanged event, AddMedicationState state) {
    final frequencyNumber = event.frequencyNumber;
    return state.copyWith(
      frequencyNumber: frequencyNumber,
      status: Formz.validate([state.nameInput]),
    );
  }

  Stream<AddMedicationState> _mapAddMedicationSubmittedToState(AddMedicationSubmitted event, AddMedicationState state) async* {
    final FormzStatus status = Formz.validate([state.nameInput]);
    final MedicationModel medication = new MedicationModel(
      state.nameInput.value,
      ToString.timeOfDayToString(state.timeInput),
      state.frequency,
      double.parse(state.frequencyNumber),
      state.repeatWeekDays,
    );
    if (status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      try {
        if (Authentication.getUserRole() == UserRole.caregiver) {
          await MedicationManager.saveMedication(medication, Authentication.getUserBond(), true);
        }
        else {
          await MedicationManager.saveMedication(medication, Authentication.getCurrentUser().email, true);
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

  AddMedicationState _mapAddMedicationRepeatWeekDaysChangedToState(AddMedicationRepeatWeekDaysChanged event, AddMedicationState state) {
    final repeatWeekDays = event.repeatWeekDays;
    return state.copyWith(
      repeatWeekDays: repeatWeekDays,
      status: Formz.validate([state.nameInput]),
    );
  }

}
