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
            SizedBox(
              height: 5,
            ),
            Text("ReMe", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.20, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)),
            Text("Recuerda Me", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.085, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(250),
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Icon(Icons.psychology, size: MediaQuery.of(context).size.width * 0.50, color: Theme.of(context).colorScheme.onPrimary,),
            ),
            SizedBox(
              height: 20,
            ),
            LoginForm(),
            SizedBox(
              height: 40,
            ),
            Text("¿No tienes una cuenta?", style: TextStyle(fontSize: 20)),
            SizedBox(
              height: 20,
            ),
            RegistrerButton(),
          ],
        ),
      ),
    );
  }
}