import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_asistente_memoria/functions/activity_manager.dart';
import 'package:flutter_asistente_memoria/functions/authentication.dart';
import 'package:flutter_asistente_memoria/model/activity_model.dart';
import 'package:flutter_asistente_memoria/model/name_input.dart';
import 'package:flutter_asistente_memoria/model/user.dart';
import 'package:formz/formz.dart';

part 'add_activity_event.dart';
part 'add_activity_state.dart';

class AddActivityBloc extends Bloc<AddActivityEvent, AddActivityState> {
  AddActivityBloc() : super(AddActivityState());

  @override
  Stream<AddActivityState> mapEventToState(
    AddActivityEvent event,
  ) async* {
    if (event is AddActivityStarted) {
      yield _mapAddActivityStartedToState(event, state);
    }
    if (event is AddActivityStart) {
      yield _mapAddActivityStartToState(event, state);
    }
    if (event is AddActivityTitleChanged) {
      yield _mapAddActivityTitleChangedToState(event, state);
    }
    if (event is AddActivityStepChanged) {
      yield _mapAddActivityStepChangedToState(event, state);
    }
    if (event is AddActivityAddStep) {
      yield _mapAddActivityAddStepToState(event, state);
    }
    if (event is AddActivityNextStep) {
      yield _mapAddActivityNextStepToState(event, state);
    }
    if (event is AddActivityPreviousStep) {
      yield _mapAddActivityPreviousStepToState(event, state);
    }
    else if (event is AddActivitySubmitted) {
      yield* _mapAddActivitySubmittedToState(event, state);
    }
    else if (event is AddActivityEditedSubmitted) {
      yield* _mapAddActivityEditedSubmittedToState(event, state);
    }
    else if (event is AddActivityDelete) {
      yield* _mapAddActivityDeleteToState(event, state);
    }
  }

  AddActivityState _mapAddActivityStartedToState(
      AddActivityStarted event, AddActivityState state) {
    return state.copyWith(
      stepInd: 0,
      steps: event.activityModel.steps,
      titleInput: NameInput.dirty(event.activityModel.tittle),
      status: FormzStatus.valid,
      activityInitial: event.activityModel,
    );
  }

  AddActivityState _mapAddActivityStartToState(
      AddActivityStart event, AddActivityState state) {
    return state.copyWith(
      stepInd: 0,
    );
  }

  AddActivityState _mapAddActivityTitleChangedToState(
      AddActivityTitleChanged event, AddActivityState state) {
    final titleInput = NameInput.dirty(event.titleInput);
    return state.copyWith(
      titleInput: titleInput,
      status: Formz.validate([titleInput]),
    );
  }

  AddActivityState _mapAddActivityStepChangedToState(
      AddActivityStepChanged event, AddActivityState state) {
    final stepInput = NameInput.dirty(event.stepInput);
    List<String> stepsAux = List.from(state.steps);
    stepsAux[state.stepInd] = stepInput.value;
    return state.copyWith(
      steps: stepsAux,
      status: Formz.validate([stepInput]),
    );
  }

  AddActivityState _mapAddActivityAddStepToState(
      AddActivityAddStep event, AddActivityState state) {
    final List<String> stepsAux = List.from(state.steps);
    final stepIndAux = state.stepInd + 1;
    stepsAux.add('');
    return state.copyWith(
      steps: stepsAux,
      stepInd: stepIndAux,
    );
  }

  AddActivityState _mapAddActivityNextStepToState(
      AddActivityNextStep event, AddActivityState state) {
    final stepInd = state.stepInd + 1;
    return state.copyWith(
      stepInd: stepInd,
    );
  }

  AddActivityState _mapAddActivityPreviousStepToState(
      AddActivityPreviousStep event, AddActivityState state) {
    final stepInd = state.stepInd - 1;
    return state.copyWith(
      stepInd: stepInd,
    );
  }

  Stream<AddActivityState> _mapAddActivitySubmittedToState(
      AddActivitySubmitted event, AddActivityState state) async* {
    final FormzStatus status = Formz.validate([state.titleInput]);
    final ActivityModel activity = new ActivityModel(
      state.titleInput.value,
      state.steps,
    );
    if (status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      try {
        if (Authentication.getUserRole() == UserRole.caregiver) {
          await ActivityManager.saveActivity(
              activity, Authentication.getUserBond());
        } else {
          await ActivityManager.saveActivity(
              activity, Authentication.getCurrentUser().email);
        }
        yield state.copyWith(status: FormzStatus.submissionSuccess);
      } on Exception {
        yield state.copyWith(status: FormzStatus.submissionFailure);
      }
    } else {
      yield state.copyWith(
        status: FormzStatus.invalid,
      );
    }
  }

  Stream<AddActivityState> _mapAddActivityEditedSubmittedToState(
      AddActivityEditedSubmitted event, AddActivityState state) async* {
    final FormzStatus status = Formz.validate([state.titleInput]);
    final ActivityModel activity = new ActivityModel(
      state.titleInput.value,
      state.steps,
    );
    final String userEmail;

    if (status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);

      if (Authentication.getUserRole() == UserRole.caregiver) {
        userEmail = Authentication.getUserBond();
      } else {
        userEmail = Authentication.getCurrentUser().email;
      }

      if (state.activityInitial.tittle != state.titleInput.value) {
        try {
          await ActivityManager.deleteActivity(
              state.activityInitial, userEmail);
        } on Exception {
          yield state.copyWith(status: FormzStatus.submissionFailure);
        }
      }

      try {
        await ActivityManager.saveActivity(activity, userEmail);
        yield state.copyWith(status: FormzStatus.submissionSuccess);
      } on Exception {
        yield state.copyWith(status: FormzStatus.submissionFailure);
      }
    } else {
      yield state.copyWith(
        status: FormzStatus.invalid,
      );
    }
  }

  Stream<AddActivityState> _mapAddActivityDeleteToState(AddActivityDelete event, AddActivityState state) async* {
    var userEmail;
    yield ActivityDeletingState();
    if (Authentication.getUserRole() == UserRole.caregiver) {
      userEmail = Authentication.getUserBond();
    }
    else {
      userEmail = Authentication.getCurrentUser().email;
    }
    try {
      await ActivityManager.deleteActivity(state.activityInitial, userEmail);
    } on Exception {
      yield ActivityDeleteErrorState();
    }
    yield ActivityDeleteSuccessState();
  }
}
