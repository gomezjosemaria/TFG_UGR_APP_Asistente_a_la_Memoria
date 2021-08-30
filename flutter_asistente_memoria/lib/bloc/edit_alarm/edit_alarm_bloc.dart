import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/functions/alarm_manager.dart';
import 'package:flutter_asistente_memoria/functions/authentication.dart';
import 'package:flutter_asistente_memoria/functions/to_string.dart';
import 'package:flutter_asistente_memoria/model/alarm_model.dart';
import 'package:flutter_asistente_memoria/model/name_input.dart';
import 'package:flutter_asistente_memoria/model/user.dart';
import 'package:formz/formz.dart';

part 'edit_alarm_event.dart';
part 'edit_alarm_state.dart';

class EditAlarmBloc extends Bloc<EditAlarmEvent, EditAlarmState> {
  EditAlarmBloc() : super(EditAlarmState());

  @override
  Stream<EditAlarmState> mapEventToState(
    EditAlarmEvent event,
  ) async* {
    if (event is EditAlarmStarted) {
      yield _mapEditAlarmStartedToState(event, state);
    }
    else if (event is EditAlarmTitleChanged) {
      yield _mapEditAlarmTitleChangedToState(event, state);
    }
    else if (event is EditAlarmTimeChanged) {
      yield _mapEditAlarmTimeChangedToState(event, state);
    }
    else if (event is EditAlarmRepeatChanged) {
      yield _mapEditAlarmRepeatChangedToState(event, state);
    }
    else if (event is EditAlarmRepeatWeekDaysChanged) {
      yield _mapEditAlarmRepeatWeekDaysChangedToState(event, state);
    }
    else if (event is EditAlarmActiveChanged) {
      yield _mapEditAlarmActiveChangedToState(event, state);
    }
    else if (event is EditAlarmSubmitted) {
      yield* _mapEditAlarmSubmittedToState(event, state);
    }
    else if (event is EditAlarmDelete) {
      yield* _mapEditAlarmDeleteToState(event, state);
    }
    else if (event is EditAlarmDeactivate) {
      yield* _mapEditAlarmDeactivateToState(event, state);
    }
  }

  Stream<EditAlarmState> _mapEditAlarmSubmittedToState(EditAlarmSubmitted event, EditAlarmState state) async* {
    final FormzStatus status = Formz.validate([state.titleInput]);
    final AlarmModel alarm = new AlarmModel(
      state.titleInput.value,
      ToString.timeOfDayToString(state.timeInput),
      state.repeat,
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

      if (event.alarmUnmodified.tittle != state.titleInput.value || event.alarmUnmodified.time != ToString.timeOfDayToString(state.timeInput)) {
        try {
          await AlarmManager.deleteAlarm(event.alarmUnmodified, userEmail, event.activateUnmodified);
        } on Exception {
          yield state.copyWith(status: FormzStatus.submissionFailure);
        }
      }

      try {
        await AlarmManager.saveAlarm(alarm, userEmail, state.active);
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

  EditAlarmState _mapEditAlarmActiveChangedToState(EditAlarmActiveChanged event, EditAlarmState state) {
    final active = event.active;
    return state.copyWith(
      active: active,
      status: Formz.validate([state.titleInput]),
    );
  }

  EditAlarmState _mapEditAlarmRepeatWeekDaysChangedToState(EditAlarmRepeatWeekDaysChanged event, EditAlarmState state) {
    final repeatWeekDays = event.repeatWeekDays;
    return state.copyWith(
      repeatWeekDays: repeatWeekDays,
      status: Formz.validate([state.titleInput]),
    );
  }

  EditAlarmState _mapEditAlarmRepeatChangedToState(EditAlarmRepeatChanged event, EditAlarmState state) {
    final repeat = event.repeat;
    return state.copyWith(
      repeat: repeat,
      status: Formz.validate([state.titleInput]),
    );
  }

  EditAlarmState _mapEditAlarmTimeChangedToState(EditAlarmTimeChanged event, EditAlarmState state) {
    final timeInput = event.timeInput;
    return state.copyWith(
      timeInput: timeInput,
      status: Formz.validate([state.titleInput]),
    );
  }

  EditAlarmState _mapEditAlarmTitleChangedToState(EditAlarmTitleChanged event, EditAlarmState state) {
    final titleInput = NameInput.dirty(event.titleInput);
    return state.copyWith(
      titleInput: titleInput,
      status: Formz.validate([titleInput]),
    );
  }

  EditAlarmState _mapEditAlarmStartedToState(EditAlarmStarted event, EditAlarmState state) {
    return state.copyWith(
      status: Formz.validate([NameInput.dirty(event.alarm.tittle)]),
      titleInput: NameInput.dirty(event.alarm.tittle),
      timeInput: ToString.stringToTimeOfDay(event.alarm.time),
      repeat: event.alarm.repeat,
      repeatWeekDays: event.alarm.repeatWeekDays,
      active: event.activated,
    );
  }

  Stream<EditAlarmState> _mapEditAlarmDeleteToState(EditAlarmDelete event, EditAlarmState state) async* {
    var userEmail;
    yield EditAlarmDeletingState();
    if (Authentication.getUserRole() == UserRole.caregiver) {
      userEmail = Authentication.getUserBond();
    }
    else {
      userEmail = Authentication.getCurrentUser().email;
    }
    try {
      await AlarmManager.deleteAlarm(event.alarmUnmodified, userEmail, event.activateUnmodified);
    } on Exception {
      yield EditAlarmDeleteErrorState();
    }
    yield EditAlarmDeleteSuccessState();
  }

  Stream<EditAlarmState> _mapEditAlarmDeactivateToState(EditAlarmDeactivate event, EditAlarmState state) async* {
    var userEmail;
    yield EditAlarmDeactivatingState();
    if (Authentication.getUserRole() == UserRole.caregiver) {
      userEmail = Authentication.getUserBond();
    }
    else {
      userEmail = Authentication.getCurrentUser().email;
    }
    try {
      await AlarmManager.deleteAlarm(event.alarmUnmodified, userEmail, event.activateUnmodified);
      await AlarmManager.saveAlarm(event.alarmUnmodified, userEmail, !event.activateUnmodified);
    } on Exception {
      yield EditAlarmDeactivateErrorState();
    }
    yield EditAlarmDeactivateSuccessState();
  }
}
