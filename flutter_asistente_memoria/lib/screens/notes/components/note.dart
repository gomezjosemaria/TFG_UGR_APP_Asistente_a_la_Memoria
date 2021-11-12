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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(noteModel.time),
                  Switch(value: activated, onChanged: null),
                ],
              ),
              Text(noteModel.text),
            ],
          ),
        ),
      ),
    );
  }
}