import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/screens/add_activity/components/add_activity_step_input.dart';
import 'package:flutter_asistente_memoria/screens/edit_activity/components/edit_activity_button.dart';

class EditActivityLastStepForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AddActivityStepInput(),
        SizedBox(
          width: double.infinity,
          height: 10.0,
        ),
        EditActivityButton(),
      ],
    );
  }
}
