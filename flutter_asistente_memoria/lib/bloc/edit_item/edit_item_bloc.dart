import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_asistente_memoria/functions/authentication.dart';
import 'package:flutter_asistente_memoria/functions/item_manager.dart';
import 'package:flutter_asistente_memoria/model/item_model.dart';
import 'package:flutter_asistente_memoria/model/name_input.dart';
import 'package:flutter_asistente_memoria/model/user.dart';
import 'package:formz/formz.dart';

part 'edit_item_event.dart';
part 'edit_item_state.dart';

class EditItemBloc extends Bloc<EditItemEvent, EditItemState> {
  EditItemBloc() : super(EditItemState());
  
    @override
    Stream<EditItemState> mapEventToState(
        EditItemEvent event,
        ) async* {
      if (event is EditItemStarted) {
        yield _mapEditItemStartedToState(event, state);
      }
      else if (event is EditItemNameChanged) {
        yield _mapEditItemNameChangedToState(event, state);
      }
      else if (event is EditItemSubmitted) {
        yield* _mapEditItemSubmittedToState(event, state);
      }
      else if (event is EditItemDelete) {
        yield* _mapEditItemDeleteToState(event, state);
      }
    }

    Stream<EditItemState> _mapEditItemSubmittedToState(EditItemSubmitted event, EditItemState state) async* {
      final FormzStatus status = Formz.validate([state.nameInput]);
      final ItemModel item = new ItemModel(
        state.nameInput.value,
        event.itemUnmodified.cart,
      );

      final String userEmail;

      if (status.isValidated) {

        yield state.copyWith(status: FormzStatus.submissionInProgress);

        if (Authentication.getUserRole() == UserRole.caregiver) {
          userEmail = Authentication.getUserBond();
        }
        else {
          userEmail = Authentication.getCurrentUser().email;
        }

        if (event.itemUnmodified.name != state.nameInput.value) {
          try {
            await ItemManager.deleteItem(event.itemUnmodified, userEmail);
          } on Exception {
            yield state.copyWith(status: FormzStatus.submissionFailure);
          }
        }

        try {
          await ItemManager.saveItem(item, userEmail);
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

    EditItemState _mapEditItemNameChangedToState(EditItemNameChanged event, EditItemState state) {
      final nameInput = NameInput.dirty(event.nameInput);
      return state.copyWith(
        nameInput: nameInput,
        status: Formz.validate([nameInput]),
      );
    }

    EditItemState _mapEditItemStartedToState(EditItemStarted event, EditItemState state) {
      print("started" + event.item.toString());
      return state.copyWith(
        status: Formz.validate([NameInput.dirty(event.item.name)]),
        nameInput: NameInput.dirty(event.item.name),
      );
    }

    Stream<EditItemState> _mapEditItemDeleteToState(EditItemDelete event, EditItemState state) async* {
      var userEmail;
      yield EditItemDeletingState();
      if (Authentication.getUserRole() == UserRole.caregiver) {
        userEmail = Authentication.getUserBond();
      }
      else {
        userEmail = Authentication.getCurrentUser().email;
      }
      try {
        await ItemManager.deleteItem(event.itemUnmodified, userEmail);
      } on Exception {
        yield EditItemDeleteErrorState();
      }
      yield EditItemDeleteSuccessState();
      print("se lanzó");
    }
  }
