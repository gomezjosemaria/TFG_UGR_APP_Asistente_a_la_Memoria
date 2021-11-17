import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_asistente_memoria/functions/authentication.dart';
import 'package:flutter_asistente_memoria/model/user.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationState());

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationStarted) {
      UserModel userModel = Authentication.getCurrentUser();
      if (userModel.id == '') {
        yield state.unauthenticated();
      }
      else {
        await Authentication.loadUserRole();
        await Authentication.loadUserBond();
        await Authentication.loadSimplify();
        yield state.authenticated(userModel);
      }
    }
    else if (event is AuthenticationSingIn) {
      yield _mapAuthenticationSingInToState(event);
    }
    else if (event is AuthenticationSingOut) {
      yield _mapAuthenticationSingOutToState();
    }
  }

  AuthenticationState _mapAuthenticationSingInToState(AuthenticationSingIn event) {
    return state.authenticated(event.user);
  }

  AuthenticationState _mapAuthenticationSingOutToState() {
    return state.unauthenticated();
  }
}
