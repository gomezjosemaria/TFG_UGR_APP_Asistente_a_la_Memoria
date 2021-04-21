import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/screens/sign_up/sign_up.dart';

class RegistrerButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60.0,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: StadiumBorder(),
        ),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUp()));
        },
        child: Text("Regístrate")
      ),
    );
  }
}