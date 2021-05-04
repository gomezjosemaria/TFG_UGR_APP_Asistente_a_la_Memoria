import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_asistente_memoria/functions/authentication.dart';
import 'package:flutter_asistente_memoria/model/user.dart';

part 'role_event.dart';
part 'role_state.dart';

class RoleBloc extends Bloc<RoleEvent, RoleState> {
  RoleBloc() : super(RoleState());

  @override
  Stream<RoleState> mapEventToState(
    RoleEvent event,
  ) async* {
    if (event is RoleStarted) {
      await Authentication.loadUserRole();
      yield _mapChooseRoleStartedToState();
    }
    else if (event is RoleSelection) {
      yield _mapChooseRoleSelectionToState();
    }
    else if (event is RoleCaregiver) {
      yield _mapChooseRoleCaregiverToState();
    }
    else if (event is RoleCareReceiver) {
      yield _mapChooseRoleCareReceiverToState();
    }
  }

  RoleState _mapChooseRoleStartedToState() {
    UserRole userRole = Authentication.getUserRole();
    if (userRole == UserRole.caregiver) {
      return state.caregiver();
    }
    else if (userRole == UserRole.careReceiver) {
      return state.careReceiver();
    }
    else {
      return state.unselected();
    }
  }

  RoleState _mapChooseRoleSelectionToState() {
    return state.unselected();
  }

  RoleState _mapChooseRoleCaregiverToState() {
    return state.caregiver();
  }

  RoleState _mapChooseRoleCareReceiverToState() {
    return state.careReceiver();
  }
}
