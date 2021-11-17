import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/bloc/add_activity/add_activity_bloc.dart';
import 'package:flutter_asistente_memoria/screens/activities/activities.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'add_activity_step_input.dart';

class AddActivityForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ActivityTitleInput(),
        SizedBox(
          width: double.infinity,
          height: 10.0,
        ),
        AddActivityStepInput(),
        SizedBox(
          width: double.infinity,
          height: 20.0,
        ),
        _AddActivityButton(),
      ],
    );
  }
}

class _AddActivityButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddActivityBloc, AddActivityState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Activities()));
        }
      },
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          height: 60.0,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: StadiumBorder(),
            ),
            onPressed: state.status.isSubmissionInProgress
                ? null
                : () {
                    context
                        .read<AddActivityBloc>()
                        .add(const AddActivitySubmitted());
                  },
            child: state.status.isSubmissionInProgress
                ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
                : Text("Guardar", style: TextStyle(fontSize: 25)),
          ),
        );
      },
    );
  }
}

class _ActivityTitleInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Título',
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 25)
          ),
        ),
        SizedBox(
          height: 10,
        ),
        BlocBuilder<AddActivityBloc, AddActivityState>(
            builder: (context, state) {
          TextEditingController _controller = TextEditingController();
          _controller.value = TextEditingValue(text: state.titleInput.value);
          var cursorPos = _controller.selection;
          if (cursorPos.start > _controller.text.length) {
            cursorPos = TextSelection.fromPosition(
                TextPosition(offset: _controller.text.length));
          }
          _controller.selection = cursorPos;
          return TextField(
            key: const Key('addActivityForm_titleInput_textField'),
            onChanged: (titleInput) => context
                .read<AddActivityBloc>()
                .add(AddActivityTitleChanged(titleInput)),
            controller: new TextEditingController.fromValue(
                new TextEditingValue(
                    text: state.titleInput.value,
                    selection: new TextSelection.collapsed(
                        offset: state.titleInput.value.length))),
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
              prefixIcon: Icon(
                Icons.directions_run,
              ),
              hintText: "Introduce un título para la actividad",
            ),
            style: TextStyle(fontSize: 20),
          );
        }),
      ],
    );
  }
}
