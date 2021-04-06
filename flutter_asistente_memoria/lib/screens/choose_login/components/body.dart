import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/components/horizontal_button.dart';
import 'package:flutter_asistente_memoria/screens/login_care_receiver/login_care_receiver.dart';
import 'package:flutter_asistente_memoria/screens/login_caregiver/login_caregiver.dart';

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
              "Asistente a la Memoria",
            ),
            HorizontalButton(
              text: "Iniciar sesión como paciente",
                pressed: () {Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Logincarereceiver()),
                );
                }
            ),
            SizedBox(
              height: 20,
            ),
            HorizontalButton(
              text: "Iniciar sesión como cuidador",
              pressed: () {Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Logincaregiver()),
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}