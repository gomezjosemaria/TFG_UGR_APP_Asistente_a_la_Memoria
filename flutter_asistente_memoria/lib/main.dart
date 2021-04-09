import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/screens/login/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Asistente Memoria',
      theme: ThemeData(),
      home: Login(),
    );
  }
}
