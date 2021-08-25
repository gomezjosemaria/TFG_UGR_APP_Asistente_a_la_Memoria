import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/functions/alarm_manager.dart';
import 'package:flutter_asistente_memoria/functions/authentication.dart';
import 'package:flutter_asistente_memoria/functions/to_string.dart';
import 'package:flutter_asistente_memoria/model/alarm.dart';
import 'package:flutter_asistente_memoria/model/name_input.dart';
import 'package:flutter_asistente_memoria/model/user.dart';
import 'package:formz/formz.dart';

part 'add_alarm_event.dart';
part 'add_alarm_state.dart';

class AddAlarmBloc extends Bloc<AddAlarmEvent, AddAlarmState> {
  AddAlarmBloc() : super(AddAlarmState());

  @override
  Stream<AddAlarmState> mapEventToState(
    AddAlarmEvent event,
  ) async* {
    if (event is AddAlarmTitleChanged) {
      yield _mapAddAlarmTitleChangedToState(event, state);
    }
    else if (event is AddAlarmTimeChanged) {
      yield _mapAddAlarmTimeChangedToState(event, state);
    }
    else if (event is AddAlarmRepeatChanged) {
      yield _mapAddAlarmRepeatChangedToState(event, state);
    }
    else if (event is AddAlarmRepeatWeekDaysChanged) {
      yield _mapAddAlarmRepeatWeekDaysChangedToState(event, state);
    }
    else if (event is AddAlarmSubmitted) {
      yield* _mapAddAlarmSubmittedToState(event, state);
    }
  }

  AddAlarmState _mapAddAlarmTitleChangedToState(AddAlarmTitleChanged event, AddAlarmState state) {
    final titleInput = NameInput.dirty(event.titleInput);
    return state.copyWith(
      titleInput: titleInput,
      status: Formz.validate([titleInput]),
    );
  }

  AddAlarmState _mapAddAlarmTimeChangedToState(AddAlarmTimeChanged event, AddAlarmState state) {
    final timeInput = event.timeInput;
    return state.copyWith(
      timeInput: timeInput,
      status: Formz.validate([state.titleInput]),
    );
  }

  AddAlarmState _mapAddAlarmRepeatChangedToState(AddAlarmRepeatChanged event, AddAlarmState state) {
    final repeat = event.repeat;
    return state.copyWith(
      repeat: repeat,
      status: Formz.validate([state.titleInput]),
    );
  }

  AddAlarmState _mapAddAlarmRepeatWeekDaysChangedToState(AddAlarmRepeatWeekDaysChanged event, AddAlarmState state) {
    final repeatWeekDays = event.repeatWeekDays;
    return state.copyWith(
      repeatWeekDays: repeatWeekDays,
      status: Formz.validate([state.titleInput]),
    );
  }

  Stream<AddAlarmState> _mapAddAlarmSubmittedToState(AddAlarmSubmitted event, AddAlarmState state) async* {
    final FormzStatus status = Formz.validate([state.titleInput]);
    final AlarmModel alarm = new AlarmModel(
      state.titleInput.value,
      ToString.timeOfDayToString(state.timeInput),
      state.repeat,
      state.repeatWeekDays,
    );
    if (status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      try {
        if (Authentication.getUserRole() == UserRole.caregiver) {
          await AlarmManager.saveAlarm(alarm, Authentication.getUserBond(), true);
        }
        else {
          await AlarmManager.saveAlarm(alarm, Authentication.getCurrentUser().email, true);
        }
        yield state.copyWith(status: FormzStatus.submissionSuccess);
      } on Exception {
        yield state.copyWith(status: FormzStatus.submissionFailure);
      }
    }
    else {
      yield state.copyWith(
        status: FormzStatus.invalid,
        titleInput: state.titleInput,
        timeInput: state.timeInput,
        repeat: state.repeat,
        repeatWeekDays: state.repeatWeekDays,
      );
    }
  }
}
