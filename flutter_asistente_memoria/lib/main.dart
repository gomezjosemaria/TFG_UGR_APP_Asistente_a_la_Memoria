import 'package:flutter/material.dart';
import 'file:///C:/Users/chemi/OneDrive/Escritorio/DGPGIT/TFG_UGR_APP_Asistente_a_la_Memoria/flutter_asistente_memoria/lib/screens/choose_login/choose_login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Asistente Memoria',
      theme: ThemeData(),
      home: ChooseLogin(),
    );
  }
}
