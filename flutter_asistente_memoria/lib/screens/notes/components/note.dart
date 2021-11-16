import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/model/note_model.dart';
import 'package:flutter_asistente_memoria/screens/edit_note/edit_note.dart';

class Note extends StatelessWidget {

  const Note({Key? key, required this.noteModel, required this.activated}) : super(key: key);

  final NoteModel noteModel;
  final bool activated;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditNote(noteModel: noteModel)));
        },
        child: Container(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 10.0,
              ),
              Text(noteModel.text, style: TextStyle(fontSize: 25)),
              SizedBox(
                width: double.infinity,
                height: 10.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}