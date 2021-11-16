import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/bloc/edit_note/edit_note_bloc.dart';
import 'package:flutter_asistente_memoria/model/note_model.dart';
import 'package:flutter_asistente_memoria/screens/notes/notes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteNoteButton extends StatelessWidget {
  final NoteModel noteModel;

  const DeleteNoteButton({Key? key, required this.noteModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditNoteBloc, EditNoteState>(
      listenWhen: (previous, current) =>
      previous is EditNoteDeleteState && current is EditNoteDeleteState && previous != current,
      listener: (context, state) {
        if (state is EditNoteDeleteSuccessState) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => Notes()));
        }
      },
      buildWhen: (previous, current) =>
      previous is EditNoteDeleteState && current is EditNoteDeleteState && previous != current,
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          height: 60.0,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: StadiumBorder(),
            ),
            onPressed: state is EditNoteDeletingState ? null : () {
              context.read<EditNoteBloc>().add(EditNoteDelete(noteModel));
            },
            child: state is EditNoteDeletingState
                ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
                : Text("Eliminar", style: TextStyle(fontSize: 25)),
          ),
        );
      },
    );
  }
}