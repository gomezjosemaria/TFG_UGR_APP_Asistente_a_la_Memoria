import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_asistente_memoria/model/email_input.dart';
import 'package:flutter_asistente_memoria/model/password_input.dart';
import 'package:formz/formz.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginEmailInputChanged) {
      yield _mapLoginEmailInputChangedToState(event, state);
    }
    else if (event is LoginPasswordInputChanged) {
      yield _mapLoginPasswordInputChangedToState(event, state);
    }
  }

  LoginState _mapLoginEmailInputChangedToState(LoginEmailInputChanged event, LoginState state) {
    final emailInput = EmailInput.dirty(event.emailInput);
    return state.copyWith(
      emailInput: emailInput,
      formzStatus: Formz.validate([state.passwordInput, emailInput]),
    );
  }

  LoginState _mapLoginPasswordInputChangedToState(LoginPasswordInputChanged event, LoginState state) {
    final passwordInput = PasswordInput.dirty(event.passwordInput);
    return state.copyWith(
      passwordInput: passwordInput,
      formzStatus: Formz.validate([passwordInput, state.emailInput]),
    );
  }

}

