import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/bloc/add_activity/add_activity_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddActivityStepInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Indicaciones',
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 25),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        BlocBuilder<AddActivityBloc, AddActivityState>(
            builder: (context, state) {
          TextEditingController _controller = TextEditingController();
          _controller.value =
              TextEditingValue(text: state.steps[state.stepInd]);
          var cursorPos = _controller.selection;
          if (cursorPos.start > _controller.text.length) {
            cursorPos = TextSelection.fromPosition(
                TextPosition(offset: _controller.text.length));
          }
          _controller.selection = cursorPos;
          return TextField(
            key: const Key('addActivityForm_stepInput_textField'),
            onChanged: (stepInput) => context
                .read<AddActivityBloc>()
                .add(AddActivityStepChanged(stepInput)),
            controller: new TextEditingController.fromValue(
                new TextEditingValue(
                    text: state.steps[state.stepInd],
                    selection: new TextSelection.collapsed(
                        offset: state.steps[state.stepInd].length))),
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
              hintText: "Introduce las indicaciones",
            ),
            keyboardType: TextInputType.multiline,
            minLines: 10,
            maxLines: 10,
            style: TextStyle(fontSize: 20)
          );
        }),
      ],
    );
  }
}
