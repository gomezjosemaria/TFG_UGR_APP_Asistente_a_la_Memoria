import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/bloc/sign_up/sign_up_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'components/body.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Iniciar Sesión', style: TextStyle(fontSize: 25)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: BlocProvider(
          create: (context) => SignUpBloc(),
          child: Body(),
        ),
      ),
    );
  }
}