import 'package:flutter/material.dart';

import 'add_appointment_button.dart';
import 'appointment_list.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SafeArea(
        child: Column(
          children: [
            AddAppointmentButton(),
            AppointmentList(),
          ],
        ),
      ),
    );
  }
}