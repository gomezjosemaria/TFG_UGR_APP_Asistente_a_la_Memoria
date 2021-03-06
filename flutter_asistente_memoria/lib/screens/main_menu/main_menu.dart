import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/screens/main_menu/components/body.dart';

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Recuerda Me', style: TextStyle(fontSize: 25)),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Semantics(
        container: true,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Body(),
          ),
        ),
      ),
    );
  }
}