import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_asistente_memoria/bloc/authentication/authentication_bloc.dart';
import 'package:flutter_asistente_memoria/functions/authentication.dart';
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
    else if (event is LoginSubmitted) {
      yield* _mapLoginSubmittedToState(event, state);
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

  Stream<LoginState> _mapLoginSubmittedToState(
    LoginSubmitted event,
    LoginState state,
  ) async* {
    final FormzStatus formzStatus = Formz.validate([state.passwordInput, state.emailInput]);
    if (formzStatus.isValidated) {
      yield state.copyWith(formzStatus: FormzStatus.submissionInProgress);
      await Future.delayed(Duration(seconds: 3)); //HAY QUE QUITARLO
      try {
        await Authentication.signInWithEmailAndPassword(state.emailInput.value, state.passwordInput.value);
        yield state.copyWith(formzStatus: FormzStatus.submissionSuccess);
        AuthenticationSingIn(Authentication.getCurrentUser());
      } on Exception {
        yield state.copyWith(formzStatus: FormzStatus.submissionFailure);
      }
    }
    else {
      yield state.copyWith(formzStatus: FormzStatus.invalid);
    }
  }

}