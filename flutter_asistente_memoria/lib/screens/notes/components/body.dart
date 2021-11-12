import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/screens/notes/components/add_note_button.dart';
import 'package:flutter_asistente_memoria/screens/notes/components/note_list.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SafeArea(
        child: Column(
          children: [
            AddNoteButton(),
            NoteList(),
          ],
        ),
      ),
    );
  }
}