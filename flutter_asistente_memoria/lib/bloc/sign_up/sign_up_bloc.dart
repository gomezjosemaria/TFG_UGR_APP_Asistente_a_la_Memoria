import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_asistente_memoria/functions/authentication.dart';
import 'package:flutter_asistente_memoria/model/email_input.dart';
import 'package:flutter_asistente_memoria/model/name_input.dart';
import 'package:flutter_asistente_memoria/model/password_input.dart';
import 'package:formz/formz.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpState());

  @override
  Stream<SignUpState> mapEventToState(
      SignUpEvent event,
  ) async* {
    if (event is SignUpNameInputChanged) {
      yield _mapSignUpNameInputChangedToState(event, state);
    }
    else if (event is SignUpEmailInputChanged) {
      yield _mapSignUpEmailInputChangedToState(event, state);
    }
    else if (event is SignUpPasswordInputChanged) {
      yield _mapSignUpPasswordInputChangedToState(event, state);
    }
    else if (event is SignUpSubmitted) {
      yield* _mapSignUpSubmittedToState(event, state);
    }
  }

  SignUpState _mapSignUpNameInputChangedToState(SignUpNameInputChanged event, SignUpState state) {
    final nameInput = NameInput.dirty(event.nameInput);
    return state.copyWith(
      nameInput: nameInput,
      formzStatus: Formz.validate([state.passwordInput, state.emailInput, nameInput]),
    );
  }

  SignUpState _mapSignUpEmailInputChangedToState(SignUpEmailInputChanged event, SignUpState state) {
    final emailInput = EmailInput.dirty(event.emailInput);
    return state.copyWith(
      emailInput: emailInput,
      formzStatus: Formz.validate([state.passwordInput, emailInput, state.nameInput]),
    );
  }

  SignUpState _mapSignUpPasswordInputChangedToState(SignUpPasswordInputChanged event, SignUpState state) {
    final passwordInput = PasswordInput.dirty(event.passwordInput);
    return state.copyWith(
      passwordInput: passwordInput,
      formzStatus: Formz.validate([passwordInput, state.emailInput, state.nameInput]),
    );
  }

  Stream<SignUpState> _mapSignUpSubmittedToState(
      SignUpSubmitted event,
      SignUpState state,
    ) async* {
    final FormzStatus formzStatus = Formz.validate([state.passwordInput, state.emailInput, state.nameInput]);
    if (formzStatus.isValidated) {
      yield state.copyWith(formzStatus: FormzStatus.submissionInProgress);
      await Future.delayed(Duration(seconds: 3));
      try {
        Authentication.signUpWithEmailAndPassword(state.nameInput.value, state.emailInput.value, state.passwordInput.value);
        yield state.copyWith(formzStatus: FormzStatus.submissionSuccess);
      } on Exception {
        yield state.copyWith(formzStatus: FormzStatus.submissionFailure);
      }
    }
    else {
      yield state.copyWith(
        formzStatus: FormzStatus.invalid,
        nameInput: state.nameInput,
        emailInput: state.emailInput,
        passwordInput: state.passwordInput,
      );
    }
  }

}


