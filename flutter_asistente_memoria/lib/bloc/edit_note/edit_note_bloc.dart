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

part 'edit_note_event.dart';
part 'edit_note_state.dart';

class EditNoteBloc extends Bloc<EditNoteEvent, EditNoteState> {
  EditNoteBloc() : super(EditNoteState());

  @override
  Stream<EditNoteState> mapEventToState(
      EditNoteEvent event,
      ) async* {
    if (event is EditNoteStarted) {
      yield _mapEditNoteStartedToState(event, state);
    }
    else if (event is EditNoteTextChanged) {
      yield _mapEditNoteTextChangedToState(event, state);
    }
    else if (event is EditNoteSubmitted) {
      yield* _mapEditNoteSubmittedToState(event, state);
    }
    else if (event is EditNoteDelete) {
      yield* _mapEditNoteDeleteToState(event, state);
    }
  }

  Stream<EditNoteState> _mapEditNoteSubmittedToState(EditNoteSubmitted event, EditNoteState state) async* {
    final FormzStatus status = Formz.validate([state.textInput]);
    final NoteModel note = new NoteModel(
      state.textInput.value,
      ToString.timeOfDayToString(TimeOfDay.now()),
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

      if (event.noteUnmodified.text != state.textInput.value) {
        try {
          await NoteManager.deleteNote(event.noteUnmodified, userEmail);
        } on Exception {
          yield state.copyWith(status: FormzStatus.submissionFailure);
        }
      }

      try {
        await NoteManager.saveNote(note, userEmail);
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

  EditNoteState _mapEditNoteTextChangedToState(EditNoteTextChanged event, EditNoteState state) {
    final textInput = NameInput.dirty(event.textInput);
    return state.copyWith(
      textInput: textInput,
      status: Formz.validate([textInput]),
    );
  }

  EditNoteState _mapEditNoteStartedToState(EditNoteStarted event, EditNoteState state) {
    return state.copyWith(
      status: Formz.validate([NameInput.dirty(event.note.text)]),
      textInput: NameInput.dirty(event.note.text),
    );
  }

  Stream<EditNoteState> _mapEditNoteDeleteToState(EditNoteDelete event, EditNoteState state) async* {
    var userEmail;
    yield EditNoteDeletingState();
    if (Authentication.getUserRole() == UserRole.caregiver) {
      userEmail = Authentication.getUserBond();
    }
    else {
      userEmail = Authentication.getCurrentUser().email;
    }
    try {
      await NoteManager.deleteNote(event.noteUnmodified, userEmail);
    } on Exception {
      yield EditNoteDeleteErrorState();
    }
    yield EditNoteDeleteSuccessState();
  }

}
