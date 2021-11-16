import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/bloc/edit_note/edit_note_bloc.dart';
import 'package:flutter_asistente_memoria/model/note_model.dart';
import 'package:flutter_asistente_memoria/screens/notes/notes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class EditNoteForm extends StatelessWidget {

  final NoteModel noteModel;

  const EditNoteForm({Key? key, required this.noteModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _EditNoteTextInput(),
        SizedBox(
          width: double.infinity,
          height: 20.0,
        ),
        _EditNoteButton(noteModel: noteModel),
      ],
    );
  }
}

class _EditNoteButton extends StatelessWidget {
  final NoteModel noteModel;

  const _EditNoteButton({Key? key, required this.noteModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditNoteBloc, EditNoteState>(
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
              context.read<EditNoteBloc>().add(EditNoteSubmitted(noteModel));
            },
            child: state.status.isSubmissionInProgress
                ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
                : Text("Guardar cambios", style: TextStyle(fontSize: 25)),
          ),
        );
      },
    );
  }
}

class _EditNoteTextInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Nota',
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 25),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        BlocBuilder<EditNoteBloc, EditNoteState>(
            builder: (context, state) {
              TextEditingController _controller = TextEditingController();
              _controller.value = TextEditingValue(text: state.textInput.value);
              var cursorPos = _controller.selection;
              if (cursorPos.start > _controller.text.length) {
                cursorPos = TextSelection.fromPosition(TextPosition(offset: _controller.text.length));
              }
              _controller.selection = cursorPos;
              return TextField(
                key: const Key('editNoteForm_textInput_textField'),
                onChanged: (textInput) => context.read<EditNoteBloc>().add(EditNoteTextChanged(textInput)),
                controller: new TextEditingController.fromValue(new TextEditingValue(text: state.textInput.value,selection: new TextSelection.collapsed(offset: state.textInput.value.length))),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)
                  ),
                  hintText: "Redacta la nota aquí",
                ),
                keyboardType: TextInputType.multiline,
                minLines: 10,
                maxLines: 10,
                style: TextStyle(fontSize: 20),
              );
            }
        ),
      ],
    );
  }
}