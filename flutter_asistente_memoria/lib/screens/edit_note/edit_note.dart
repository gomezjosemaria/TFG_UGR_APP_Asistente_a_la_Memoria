import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/bloc/edit_note/edit_note_bloc.dart';
import 'package:flutter_asistente_memoria/model/note_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/body.dart';

class EditNote extends StatelessWidget {

  final NoteModel noteModel;

  const EditNote({Key? key, required this.noteModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Nota', style: TextStyle(fontSize: 25)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: BlocProvider(
            create: (context) => EditNoteBloc()..add(EditNoteStarted(noteModel)),
            child: Body(noteModel: noteModel),
          ),
        ),
      ),
    );
  }
}