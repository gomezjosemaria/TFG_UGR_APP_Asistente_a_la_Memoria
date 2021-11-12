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
              Text("Notas"),
              Column(
                children: list,
              ),
            ],
          );
        } else {
          return Text('Cargando notas');
        }
      },
    );
  }
}