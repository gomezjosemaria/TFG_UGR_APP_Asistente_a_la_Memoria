import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_asistente_memoria/functions/authentication.dart';
import 'package:flutter_asistente_memoria/model/name_input.dart';
import 'package:formz/formz.dart';

part 'bond_care_receiver_event.dart';
part 'bond_care_receiver_state.dart';

class BondCareReceiverBloc extends Bloc<BondCareReceiverEvent, BondCareReceiverState> {
  BondCareReceiverBloc() : super(BondCareReceiverState());

  @override
  Stream<BondCareReceiverState> mapEventToState(
    BondCareReceiverEvent event,
  ) async* {
    if (event is BondCareReceiverEmailInputChanged) {
      yield _mapBondCareReceiverEmailInputChangedToState(event, state);
    }
    else if (event is BondCareReceiverCodeInputChanged) {
      yield _mapBondCareReceiverCodeInputChangedToState(event, state);
    }
    else if (event is BondCareReceiverSubmitted) {
      yield* _mapBondCareReceiverSubmittedToState(event, state);
    }
  }

  BondCareReceiverState _mapBondCareReceiverEmailInputChangedToState(BondCareReceiverEmailInputChanged event, BondCareReceiverState state) {
    final emailInput = NameInput.dirty(event.emailInput);
    return state.copyWith(
      emailInput: emailInput,
      status: Formz.validate([emailInput, state.codeInput]),
    );
  }

  BondCareReceiverState _mapBondCareReceiverCodeInputChangedToState(BondCareReceiverCodeInputChanged event, BondCareReceiverState state) {
    final codeInput = NameInput.dirty(event.codeInput);
    return state.copyWith(
      codeInput: codeInput,
      status: Formz.validate([state.emailInput, codeInput]),
    );
  }

  Stream<BondCareReceiverState> _mapBondCareReceiverSubmittedToState(BondCareReceiverSubmitted event, BondCareReceiverState state) async* {
    print("event recived");
    final FormzStatus status = Formz.validate([state.emailInput, state.codeInput]);
    if (status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      try {
        await Authentication.bondCurrentUser(state.emailInput.value, state.codeInput.value);
        yield state.copyWith(status: FormzStatus.submissionSuccess);
      } on Exception {
        yield state.copyWith(status: FormzStatus.submissionFailure);
      }
    }
    else {
      yield state.copyWith(status: FormzStatus.invalid);
    }
  }

}
