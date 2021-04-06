import 'package:flutter/material.dart';

class PasswordImput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Contraseña",
            textAlign: TextAlign.left,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
          obscureText: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100)
            ),
            prefixIcon: Icon(
              Icons.lock,
            ),
            hintText: "Introduce tu Contraseña",
          ),
        ),
      ],
    );
  }
}