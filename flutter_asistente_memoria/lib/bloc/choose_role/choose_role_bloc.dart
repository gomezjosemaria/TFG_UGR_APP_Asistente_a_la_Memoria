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
    if (event is ChooseRoleStarted) {
      yield _mapChooseRoleStartedToState();
    }
    else if (event is ChooseRoleSelection) {
      yield _mapChooseRoleSelectionToState();
    }
    else if (event is ChooseRoleCaregiver) {
      yield _mapChooseRoleCaregiverToState();
    }
    else if (event is ChooseRoleCareReceiver) {
      yield _mapChooseRoleCareReceiverToState();
    }
  }

  ChooseRoleState _mapChooseRoleStartedToState() {
    UserModel userModel = Authentication.getCurrentUser();
    if (userModel.role == UserRole.caregiver) {
      return state.caregiver();
    }
    else if (userModel.role == UserRole.careReceiver) {
      return state.careReceiver();
    }
    else {
      return state.unselected();
    }
  }

  ChooseRoleState _mapChooseRoleSelectionToState() {
    return state.unselected();
  }

  ChooseRoleState _mapChooseRoleCaregiverToState() {
    return state.caregiver();
  }

  ChooseRoleState _mapChooseRoleCareReceiverToState() {
    return state.careReceiver();
  }
}
