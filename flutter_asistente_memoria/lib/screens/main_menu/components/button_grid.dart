import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/functions/authentication.dart';
import 'package:flutter_asistente_memoria/model/user.dart';
import 'package:flutter_asistente_memoria/screens/alarms/alarms.dart';
import 'package:flutter_asistente_memoria/screens/appointments/appointments.dart';
import 'package:flutter_asistente_memoria/screens/main_menu/components/menu_button.dart';
import 'package:flutter_asistente_memoria/screens/medication/medication.dart';
import 'package:flutter_asistente_memoria/screens/notes/notes.dart';
import 'package:flutter_asistente_memoria/screens/planner/planner.dart';
import 'package:flutter_asistente_memoria/screens/profile/profile.dart';

class ButtonGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: ScrollPhysics(),
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
        if (Authentication.getSimplify() == false && Authentication.getUserRole() == UserRole.careReceiver || Authentication.getUserRole() == UserRole.caregiver)
          MenuButton(
          title: 'Alarmas',
          icon: Icons.alarm,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Alarms()));
          },
        ),
        if (Authentication.getSimplify() == false && Authentication.getUserRole() == UserRole.careReceiver || Authentication.getUserRole() == UserRole.caregiver)
          MenuButton(
          title: 'Medicación',
          icon: Icons.healing,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Medication()));
          },
        ),
        if (Authentication.getSimplify() == false && Authentication.getUserRole() == UserRole.careReceiver || Authentication.getUserRole() == UserRole.caregiver)
          MenuButton(
          title: 'Citas Médicas',
          icon: Icons.local_hospital,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Appointments()));
          },
        ),
        MenuButton(
          title: 'Agenda',
          icon: Icons.today,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Planner()));
          },
        ),
        if (Authentication.getSimplify() == false && Authentication.getUserRole() == UserRole.careReceiver || Authentication.getUserRole() == UserRole.caregiver)
        MenuButton(
          title: 'Notas',
          icon: Icons.sticky_note_2,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Notes()));
          },
        ),
      ],
    );
  }
}