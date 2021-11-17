import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/screens/second_menu/components/body.dart';

class SecondMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Recuerda Me', style: TextStyle(fontSize: 25)),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Body(),
        ),
      ),
    );
  }
}