import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/screens/edit_activity/components/edit_next_step_button.dart';

import 'edit_activity_last_step_form.dart';
import 'edit_previous_step_button.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SafeArea(
        child: Column(
          children: [
            EditActivityLastStepForm(),
            SizedBox(
              width: double.infinity,
              height: 20.0,
            ),
            EditPreviousStepButton(),
            SizedBox(
              width: double.infinity,
              height: 20.0,
            ),
            EditNextStepButton(),
          ],
        ),
      ),
    );
  }
}
