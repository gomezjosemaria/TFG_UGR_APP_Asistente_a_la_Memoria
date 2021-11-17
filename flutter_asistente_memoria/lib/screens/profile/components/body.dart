import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/functions/authentication.dart';
import 'package:flutter_asistente_memoria/model/user.dart';
import 'package:flutter_asistente_memoria/screens/components/log_out_button.dart';
import 'package:flutter_asistente_memoria/screens/components/simplify_button.dart';
import 'package:flutter_asistente_memoria/screens/profile/components/profile_info.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SafeArea(
        child: Column(
          children: [
            ProfileInfo(),
            SizedBox(
              height: 25,
            ),
            if (Authentication.getUserRole() == UserRole.caregiver)
            SimplifyButton(),
            if (Authentication.getUserRole() == UserRole.caregiver)
            SizedBox(
              height: 25,
            ),
            LogOutButton(),
          ],
        ),
      ),
    );
  }
}