import 'package:flutter/material.dart';

import 'add_appointment_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SafeArea(
        child: Column(
          children: [
            AddAppointmentForm(),
          ],
        ),
      ),
    );
  }
}
