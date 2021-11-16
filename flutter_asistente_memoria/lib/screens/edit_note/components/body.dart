import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/model/note_model.dart';
import 'package:flutter_asistente_memoria/screens/edit_note/components/delete_note_button.dart';
import 'package:flutter_asistente_memoria/screens/edit_note/components/edit_note_form.dart';

class Body extends StatelessWidget {

  final NoteModel noteModel;

  const Body({Key? key, required this.noteModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SafeArea(
        child: Column(
          children: [
            EditNoteForm(noteModel: noteModel),
            SizedBox(
              width: double.infinity,
              height: 20.0,
            ),
            DeleteNoteButton(noteModel: noteModel),
          ],
        ),
      ),
    );
  }
}