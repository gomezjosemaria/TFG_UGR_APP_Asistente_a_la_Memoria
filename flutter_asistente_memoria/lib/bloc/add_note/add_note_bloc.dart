import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/functions/authentication.dart';
import 'package:flutter_asistente_memoria/functions/note_manager.dart';
import 'package:flutter_asistente_memoria/functions/to_string.dart';
import 'package:flutter_asistente_memoria/model/name_input.dart';
import 'package:flutter_asistente_memoria/model/note_model.dart';
import 'package:flutter_asistente_memoria/model/user.dart';
import 'package:formz/formz.dart';

part 'add_note_event.dart';
part 'add_note_state.dart';

class AddNoteBloc extends Bloc<AddNoteEvent, AddNoteState> {
  AddNoteBloc() : super(AddNoteState());

  @override
  Stream<AddNoteState> mapEventToState(
      AddNoteEvent event,
      ) async* {
    if (event is AddNoteTextChanged) {
      yield _mapAddNoteTextChangedToState(event, state);
    }
    else if (event is AddNoteSubmitted) {
      yield* _mapAddNoteSubmittedToState(event, state);
    }
  }

  AddNoteState _mapAddNoteTextChangedToState(AddNoteTextChanged event, AddNoteState state) {
    final textInput = NameInput.dirty(event.textInput);
    return state.copyWith(
      textInput: textInput,
      status: Formz.validate([textInput]),
    );
  }

  Stream<AddNoteState> _mapAddNoteSubmittedToState(AddNoteSubmitted event, AddNoteState state) async* {
    final FormzStatus status = Formz.validate([state.textInput]);
    final TimeOfDay timeInput = TimeOfDay.now();
    final NoteModel note = new NoteModel(
      state.textInput.value,
      ToString.timeOfDayToString(timeInput),
    );
    if (status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      try {
        if (Authentication.getUserRole() == UserRole.caregiver) {
          await NoteManager.saveNote(note, Authentication.getUserBond());
        }
        else {
          await NoteManager.saveNote(note, Authentication.getCurrentUser().email);
        }
        yield state.copyWith(status: FormzStatus.submissionSuccess);
      } on Exception {
        yield state.copyWith(status: FormzStatus.submissionFailure);
      }
    }
    else {
      yield state.copyWith(
        status: FormzStatus.invalid,
        textInput: state.textInput,
      );
    }
  }
}
