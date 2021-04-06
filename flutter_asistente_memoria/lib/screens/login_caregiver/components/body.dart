import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/components/email_imput.dart';
import 'package:flutter_asistente_memoria/components/horizontal_button.dart';
import 'package:flutter_asistente_memoria/components/password_imput.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 200,
            ),
            Text(
              "Iniciar sesión como cuidador",
            ),
            EmailImput(),
            SizedBox(
              height: 10,
            ),
            PasswordImput(),
            SizedBox(
              height: 100,
            ),
            HorizontalButton(
              text: "Iniciar sesión como cuidador",
              pressed: () => null,
            ),
          ],
        )
      )
    );
  }
}