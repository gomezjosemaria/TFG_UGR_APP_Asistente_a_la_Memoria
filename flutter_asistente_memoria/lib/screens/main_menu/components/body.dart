import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/functions/authentication.dart';
import 'package:flutter_asistente_memoria/model/user.dart';
import 'button_grid.dart';
import 'next_menu_button.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SafeArea(
        child: Column(
          children: [
            ButtonGrid(),
            SizedBox(height: 20),
            if (Authentication.getSimplify() == false && Authentication.getUserRole() == UserRole.careReceiver || Authentication.getUserRole() == UserRole.caregiver)
            NextMenuButton(),
          ],
        ),
      ),
    );
  }
}