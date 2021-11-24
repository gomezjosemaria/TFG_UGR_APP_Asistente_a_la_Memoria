import 'package:flutter/material.dart';

import 'edit_activity_delete_button.dart';
import 'edit_activity_form.dart';
import 'edit_next_step_button.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SafeArea(
        child: Column(
          children: [
            EditActivityForm(),
            SizedBox(
              width: double.infinity,
              height: 20.0,
            ),
            EditNextStepButton(),
            SizedBox(
              width: double.infinity,
              height: 20.0,
            ),
            EditActivityDeleteButton(),
          ],
        ),
      ),
    );
  }
}
