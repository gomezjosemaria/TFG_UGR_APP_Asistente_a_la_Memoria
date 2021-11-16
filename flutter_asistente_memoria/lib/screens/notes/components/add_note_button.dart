import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/screens/add_note/add_note.dart';

class AddNoteButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60.0,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: StadiumBorder(),
        ),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddNote()));
        },
        child: Text("Añadir Nota", style: TextStyle(fontSize: 25)),
      ),
    );
  }
}