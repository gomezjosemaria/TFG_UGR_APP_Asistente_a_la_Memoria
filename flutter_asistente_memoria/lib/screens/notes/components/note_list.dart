import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/bloc/notes/notes_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'note.dart';

class NoteList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesBloc, NotesState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        if (state.status == NotesStatus.notesLoadedSuccessfully) {
          var list= <Widget>[];

          state.notes.forEach((i) {
            Note note = new Note(noteModel: i, activated: true);
            list.add(note);
            list.add(new SizedBox(height: 10,));
          });

          return Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 10.0,
              ),
              Text("Notas", style: TextStyle(fontSize: 25)),
              SizedBox(
                width: double.infinity,
                height: 10.0,
              ),
              Column(
                children: list,
              ),
            ],
          );
        } else {
          return Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 10.0,
              ),
              Text('Cargando notas...', style: TextStyle(fontSize: 25)),
            ],
          );
        }
      },
    );
  }
}