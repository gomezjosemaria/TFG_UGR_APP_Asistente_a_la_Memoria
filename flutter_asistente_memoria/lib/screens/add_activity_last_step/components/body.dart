import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/screens/add_activity/components/next_step_button.dart';
import 'package:flutter_asistente_memoria/screens/add_activity_last_step/components/previous_step_button.dart';

import 'add_activity_last_step_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SafeArea(
        child: Column(
          children: [
            AddActivityLastStepForm(),
            SizedBox(
              width: double.infinity,
              height: 10.0,
            ),
            PreviousStepButton(),
            SizedBox(
              width: double.infinity,
              height: 10.0,
            ),
            NextStepButton(),
          ],
        ),
      ),
    );
  }
}
