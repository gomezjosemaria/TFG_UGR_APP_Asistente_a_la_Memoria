import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/bloc/notes/notes_bloc.dart';
import 'package:flutter_asistente_memoria/screens/notes/components/body.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Notes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notas', style: TextStyle(fontSize: 25)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: BlocProvider(
            create: (context) => NotesBloc()..add(NotesStarted()),
            child: Body(),
          ),
        ),
      ),
    );
  }
}