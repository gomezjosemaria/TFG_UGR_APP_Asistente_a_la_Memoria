import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/screens/login/components/login_form.dart';
import 'package:flutter_asistente_memoria/screens/login/components/registrer_button.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SafeArea(
        child: Column(
          children: [
            LoginForm(),
            Text("¿No tienes una cuenta?"),
            RegistrerButton(),
          ],
        ),
      ),
    );
  }
}