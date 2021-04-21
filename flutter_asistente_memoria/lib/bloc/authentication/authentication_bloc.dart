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
      yield _mapAuthenticationStartedToState();
    }
    else if (event is AuthenticationSingIn) {
      yield _mapAuthenticationSingInToState(event);
    }
    else if (event is AuthenticationSingOut) {
      yield _mapAuthenticationSingOutToState();
    }
  }

  AuthenticationState _mapAuthenticationStartedToState() {
    UserModel userModel = Authentication.getCurrentUser();
    if (userModel.id == '') {
      return state.unauthenticated();
    }
    else {
      return state.authenticated(userModel);
    }
  }

  AuthenticationState _mapAuthenticationSingInToState(AuthenticationSingIn event) {
    return state.authenticated(event.user);
  }

  AuthenticationState _mapAuthenticationSingOutToState() {
    return state.unauthenticated();
  }
}
