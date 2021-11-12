import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/bloc/add_note/add_note_bloc.dart';
import 'package:flutter_asistente_memoria/screens/notes/notes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class AddNote extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Añadir Nota'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: BlocProvider(
          create: (context) => AddNoteBloc(),
          child: Align(
            alignment: Alignment.center,
            child: SafeArea(
              child: Column(
                children: [
                  _NoteTextInput(),
                  SizedBox(
                    width: double.infinity,
                    height: 10.0,
                  ),
                  _AddNoteButton()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AddNoteButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddNoteBloc, AddNoteState>(
      listenWhen: (previous, current) =>
      previous.status != current.status,
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => Notes()));
        }
      },
      buildWhen: (previous, current) =>
      previous.status != current.status,
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          height: 60.0,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: StadiumBorder(),
            ),
            onPressed: state.status.isSubmissionInProgress ? null : () {
              context.read<AddNoteBloc>().add(const AddNoteSubmitted());
            },
            child: state.status.isSubmissionInProgress
                ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
                : Text("Guardar"),
          ),
        );
      },
    );
  }
}

class _NoteTextInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Nota',
            textAlign: TextAlign.left,
          ),
        ),
        SizedBox(
          height: 10,
          width: 50,
        ),
        BlocBuilder<AddNoteBloc, AddNoteState>(
            builder: (context, state) {
              return TextField(
                key: const Key('addNoteForm_textInput_textField'),
                onChanged: (textInput) => context.read<AddNoteBloc>().add(AddNoteTextChanged(textInput)),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)
                  ),
                  hintText: "Redacta la nota aquí",
                ),
                keyboardType: TextInputType.multiline,
                minLines: 10,
                maxLines: 10,
              );
            }
        ),
      ],
    );
  }
}
