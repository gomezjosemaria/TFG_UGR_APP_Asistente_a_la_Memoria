import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/screens/profile/components/body.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil', style: TextStyle(fontSize: 25)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Body(),
      ),
    );
  }
}