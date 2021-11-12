import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_asistente_memoria/functions/authentication.dart';
import 'package:flutter_asistente_memoria/functions/note_manager.dart';
import 'package:flutter_asistente_memoria/model/note_model.dart';
import 'package:flutter_asistente_memoria/model/user.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  NotesBloc() : super(NotesState());

  @override
  Stream<NotesState> mapEventToState(
      NotesEvent event,
      ) async* {
    if (event is NotesStarted) {
      yield state.copyWith(status: NotesStatus.notesLoading);
      try {
        if (Authentication.getUserRole() == UserRole.caregiver) {
          await NoteManager.loadNotes(Authentication.getUserBond());
        }
        else if (Authentication.getUserRole() == UserRole.careReceiver) {
          await NoteManager.loadNotes(Authentication.getCurrentUserEmail());
        }
        yield state.copyWith(status: NotesStatus.notesLoadedSuccessfully, notes: NoteManager.getNotes());
      } catch (e) {
        yield state.copyWith(status: NotesStatus.error);
      }
    }
  }
}
