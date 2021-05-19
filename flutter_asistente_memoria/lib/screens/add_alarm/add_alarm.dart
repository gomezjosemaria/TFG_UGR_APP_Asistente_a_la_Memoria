import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/screens/add_alarm/components/body.dart';

class AddAlarm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Body(),
      ),
    );
  }
}