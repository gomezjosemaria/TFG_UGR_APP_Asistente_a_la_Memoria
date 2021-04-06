import 'package:flutter/material.dart';

class EmailImput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Email",
            textAlign: TextAlign.left,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100)
            ),
            prefixIcon: Icon(
              Icons.email,
            ),
            hintText: "Introduce tu Email",
          ),
        ),
      ],
    );
  }
}