import 'package:flutter/material.dart';

import 'add_activity_form.dart';
import 'next_step_button.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SafeArea(
        child: Column(
          children: [
            AddActivityForm(),
            SizedBox(
              width: double.infinity,
              height: 20.0,
            ),
            NextStepButton(),
          ],
        ),
      ),
    );
  }
}
