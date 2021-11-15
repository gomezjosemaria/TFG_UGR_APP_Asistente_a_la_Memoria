import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_asistente_memoria/functions/authentication.dart';
import 'package:flutter_asistente_memoria/functions/item_manager.dart';
import 'package:flutter_asistente_memoria/model/item_model.dart';
import 'package:flutter_asistente_memoria/model/name_input.dart';
import 'package:flutter_asistente_memoria/model/user.dart';
import 'package:formz/formz.dart';

part 'add_item_event.dart';
part 'add_item_state.dart';

class AddItemBloc extends Bloc<AddItemEvent, AddItemState> {
  AddItemBloc() : super(AddItemState());

  @override
  Stream<AddItemState> mapEventToState(AddItemEvent event) async* {
    if (event is AddItemNameChanged) {
      yield _mapAddItemNameChangedToState(event, state);
    }
    else if (event is AddItemSubmitted) {
      yield* _mapAddItemSubmittedToState(event, state);
    }
  }

  AddItemState _mapAddItemNameChangedToState(AddItemNameChanged event, AddItemState state) {
    final nameInput = event.nameInput;
    return state.copyWith(
      nameInput: NameInput.dirty(nameInput),
      status: Formz.validate([state.nameInput]),
    );
  }

  Stream<AddItemState> _mapAddItemSubmittedToState(AddItemSubmitted event, AddItemState state) async* {
    final FormzStatus status = Formz.validate([state.nameInput]);
    final ItemModel item = new ItemModel(state.nameInput.value, false);
    if (status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      try {
        if (Authentication.getUserRole() == UserRole.caregiver) {
          await ItemManager.saveItem(item, Authentication.getUserBond());
        }
        else {
          await ItemManager.saveItem(item, Authentication.getCurrentUser().email);
        }
        yield state.copyWith(status: FormzStatus.submissionSuccess);
      } on Exception {
        yield state.copyWith(status: FormzStatus.submissionFailure);
      }
    }
    else {
      yield state.copyWith(
        status: FormzStatus.invalid,
      );
    }
  }
}
