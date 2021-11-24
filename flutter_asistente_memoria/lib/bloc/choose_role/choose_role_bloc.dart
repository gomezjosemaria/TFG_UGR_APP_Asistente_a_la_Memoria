import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_asistente_memoria/functions/authentication.dart';
import 'package:flutter_asistente_memoria/model/user.dart';

part 'choose_role_event.dart';
part 'choose_role_state.dart';

class ChooseRoleBloc extends Bloc<ChooseRoleEvent, ChooseRoleState> {
  ChooseRoleBloc() : super(ChooseRoleState());

  @override
  Stream<ChooseRoleState> mapEventToState(
    ChooseRoleEvent event,
  ) async* {
    if (event is ChooseRoleCaregiver) {
      yield* _mapChooseRoleCaregiverToState();
    }
    else if (event is ChooseRoleCareReceiver) {
      yield* _mapChooseRoleCareReceiverToState();
    }
  }

  Stream<ChooseRoleState> _mapChooseRoleCaregiverToState() async* {
    yield state.caregiverSelectionProgress();
    try {
      await Authentication.setUserRole(UserRole.caregiver);
      yield state.selectionSuccess();
    } on Exception {
      yield state.error();
    }
  }

  Stream<ChooseRoleState> _mapChooseRoleCareReceiverToState() async* {
    yield state.careReceiverSelectionProgress();
    try {
      await Authentication.setUserRole(UserRole.careReceiver);
      yield state.selectionSuccess();
    } on Exception {
      yield state.error();
    }
  }
}

