import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/screens/alarms/alarms.dart';
import 'package:flutter_asistente_memoria/screens/appointments/appointments.dart';
import 'package:flutter_asistente_memoria/screens/main_menu/components/menu_button.dart';
import 'package:flutter_asistente_memoria/screens/medication/medication.dart';
import 'package:flutter_asistente_memoria/screens/profile/profile.dart';

class ButtonGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      children: [
        MenuButton(
          title: 'Perfil',
          icon: Icons.account_circle,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Profile()));
          },
        ),
        MenuButton(
          title: 'Alarmas',
          icon: Icons.alarm,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Alarms()));
          },
        ),
        MenuButton(
          title: 'Medicación',
          icon: Icons.mediation,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Medication()));
          },
        ),
        MenuButton(
          title: 'Cita Médica',
          icon: Icons.fastfood,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Appointments()));
          },
        ),
      ],
    );
  }
}